require 'spec_helper'

describe "Wants" do

    def current_user
      @auth.user
    end

  describe "user" do

    before(:each) do
      @auth = create(:auth_billy)
      login_with_oauth(@auth)
    end

    describe "index" do

      it "should load page" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/
        click_link 'Wants'
        page.should have_content('Listing wants')
      end

      it "should list wants" do
        Want.create!(:card_name => 'Card 1', :user => @auth.user)
        Want.create!(:card_name => 'Card 2', :user => @auth.user)
        click_link 'Wants'
        page.should have_content('Card 1')
        page.should have_content('Card 2')
      end

      it "should allow paging" do
        (1..100).each do  |i|
          Want.create!(:card_name => "Card #{i}", :user => @auth.user)
        end
        click_link 'Wants'
        click_link 'Next'
      end

      it "should not list other user's wants" do
        other_user = create(:admin_grant)
        Want.create(:card_name => 'Admin Card 1', :user => other_user)
        Want.create(:card_name => 'Admin Card 2', :user => other_user)
        click_link 'Wants'
        page.should_not have_content('Admin Card 1')
        page.should_not have_content('Admin Card 2')
      end

    end

    describe "create" do

      it "should create a want" do
        click_link 'Wants'
        click_link 'New Want'
        fill_in 'Card name', :with => 'Test Card'
        current_user.wants.count.should == 0
        click_button 'Create Want'
        page.should have_content('Test Card')
        current_user.wants.by_card_name('Test Card').count.should == 1
      end

      it "should not allow duplicate creations" do
        current_user.wants.create!(:card_name => 'Duplicate')
        click_link 'Wants'
        click_link 'New Want'
        fill_in 'Card name', :with => 'Duplicate'
        click_button 'Create Want'
        page.should have_content('Card name is already taken')
      end

    end

    describe "edit" do

        it "should allow to edit" do
          want = current_user.wants.create!(:card_name => 'Duplicate')
          click_link 'Wants'
          click_link "edit_want_#{want.id}"
          fill_in 'Amount', :with => '2'
          click_button 'Update Want'
          page.should have_content('Want was successfully updated.')
        end

        it "should not allow to edit another user's wants" do
          other_user = create(:admin_grant)
          want = other_user.wants.create!(:card_name => 'Only for Admin')
          visit "/wants/#{want.id}"
          page.should have_content('You are not authorized to access this page.')
        end

    end

    describe "delete" do

      it "should allow to delete" do
        want = current_user.wants.create!(:card_name => 'Delete me')
        click_link 'Wants'
        page.should have_content('Delete me')
        click_link "delete_want_#{want.id}"
        page.driver.browser.switch_to.alert.accept
        page.should have_content('Successfully deleted.')
        page.should_not have_content('Delete me')
      end

    end

  end

  describe "admin" do

    before(:each) do
      @auth = create(:auth_grant)
      login_with_oauth(@auth)
    end

    describe "index" do

      it "should list everyones wants" do
        other_user = create(:user_billy)
        Want.create(:card_name => 'Card 1', :user => other_user)
        Want.create(:card_name => 'Card 2', :user => @auth.user)
        click_link 'Wants'
        page.should have_content('Card 1')
        page.should have_content('Card 2')
      end

    end

    describe "edit" do

        it "should allow to edit another user's wants" do
          other_user = create(:user_billy)
          want = other_user.wants.create!(:card_name => 'Only for Admin')
          visit "/wants/#{want.id}"
          page.should_not have_content('You are not authorized to access this page.')
        end

    end

  end

end