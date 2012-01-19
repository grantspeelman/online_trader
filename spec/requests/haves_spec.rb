require 'spec_helper'

describe "Haves" do

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
        click_link 'I Have'
        page.should have_content('Listing haves')
      end

      it "should list haves" do
        ::Have.create!(:card_name => 'Card 1', :user => @auth.user)
        ::Have.create!(:card_name => 'Card 2', :user => @auth.user)
        click_link 'I Have'
        page.should have_content('Card 1')
        page.should have_content('Card 2')
      end

      it "should allow paging" do
        (1..100).each do  |i|
          ::Have.create!(:card_name => "Card #{i}", :user => @auth.user)
        end
        click_link 'I Have'
        click_link 'Next'
      end

      it "should not list other user's haves" do
        other_user = create(:admin_grant)
        ::Have.create!(:card_name => 'Admin Card 1', :user => other_user)
        ::Have.create!(:card_name => 'Admin Card 2', :user => other_user)
        click_link 'I Have'
        page.should_not have_content('Admin Card 1')
        page.should_not have_content('Admin Card 2')
      end

    end

    describe "create" do

      it "should create a have" do
        click_link 'I Have'
        click_link 'Add Have'
        fill_in 'Card name', :with => 'Test Card'
        current_user.haves.count.should == 0
        click_button 'Create Have'
        page.should have_content('Test Card')
        current_user.haves.by_card_name('Test Card').count.should == 1
      end

      it "should not allow duplicate creations" do
        current_user.haves.create!(:card_name => 'Duplicate')
        click_link 'I Have'
        click_link 'Add Have'
        fill_in 'Card name', :with => 'Duplicate'
        click_button 'Create Have'
        page.should have_content('Card name is already taken')
      end

    end

    describe "edit" do

        it "should allow to edit" do
          have = current_user.haves.create!(:card_name => 'Duplicate')
          click_link 'I Have'
          click_link "edit_have_#{have.id}"
          fill_in 'Amount', :with => '2'
          click_button 'Update Have'
          page.should have_content('Have was successfully updated.')
        end

        it "should not allow to edit another user's haves" do
          other_user = create(:admin_grant)
          have = other_user.haves.create!(:card_name => 'Only for Admin')
          visit "/haves/#{have.id}"
          page.should have_content('You are not authorized to access this page.')
        end

    end

    describe "delete" do

      it "should allow to delete" do
        have = current_user.haves.create!(:card_name => 'Delete me')
        click_link 'I Have'
        page.should have_content('Delete me')
        click_link "delete_have_#{have.id}"
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

      it "should list everyones haves" do
        other_user = create(:user_billy)
        ::Have.create!(:card_name => 'Card 1', :user => other_user)
        ::Have.create!(:card_name => 'Card 2', :user => @auth.user)
        click_link 'I Have'
        page.should have_content('Card 1')
        page.should have_content('Card 2')
      end

    end

    describe "edit" do

        it "should allow to edit another user's haves" do
          other_user = create(:user_billy)
          have = other_user.haves.create!(:card_name => 'Only for Admin')
          visit "/haves/#{have.id}"
          page.should_not have_content('You are not authorized to access this page.')
        end

    end

  end

end