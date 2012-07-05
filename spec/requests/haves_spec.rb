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
        page.should have_content('I Have')
      end

      it "should list haves" do
        ::Have.create!(:card_name => 'Card 1', :user => @auth.user)
        ::Have.create!(:card_name => 'Card 2', :user => @auth.user)
        click_link 'I Have'
        page.should have_content('Card 1')
        page.should have_content('Card 2')
      end

      it "should search by card_name" do
        ::Have.create!(:card_name => 'Card 1', :user => @auth.user)
        ::Have.create!(:card_name => 'Card 2', :user => @auth.user)
        visit haves_path(:card_name => 'Card 1')
        page.should have_content('Card 1')
        page.should_not have_content('Card 2')
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

      it "should allow to list other user's haves"

      it "should be able to find user's haves with my wants" do
        other_user = create(:admin_grant)
        user_kim = create(:user_kim)
        Want.create!(:card_name => 'Super Cool Card', :user => @auth.user)
        Want.create!(:card_name => 'Awesome Great Card', :user => @auth.user)
        ::Have.create(:card_name => 'Super Cool Card', :user => other_user)
        ::Have.create(:card_name => 'Awesome Great Card', :user => user_kim)
        ::Have.create(:card_name => 'Crap Card', :user => other_user)
        ::Have.create(:card_name => 'My Card', :user =>  @auth.user)
        click_link 'My Wants'
        click_link 'Find Traders'
        page.should have_content('Super Cool Card')
        page.should have_content('Awesome Great Card')
        page.should_not have_content('Crap Card')
        page.should_not have_content('My Card')
      end

      it "should allow paging of other user's haves"

    end

    describe "create" do

      it "should create a have" do
        click_link 'I Have'
        click_link 'Add Have'
        fill_in 'Card name', :with => 'Test Card'
        current_user.haves.count.should == 0
        click_button 'Create Have'
        page.should have_content('Test Card')
        current_user.haves.all(card_name: 'Test Card').count.should == 1
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
          have.reload
          have.amount.should == 2
        end

        it "should not allow to edit another user's haves" do
          other_user = create(:admin_grant)
          have = other_user.haves.create!(:card_name => 'Only for Admin')
          visit "/haves/#{have.id}/edit"
          page.should have_content('You are not authorized to access this page.')
        end

    end

    describe "delete" do

      it "should allow to delete" do
        have = current_user.haves.create!(:card_name => 'Delete me')
        click_link 'I Have'
        page.should have_content('Delete me')
        click_link "delete_have_#{have.id}"
        page.driver.browser.switch_to.alert.accept if Capybara.default_driver == :selenium
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

      #it "should list everyones haves" do
      #  other_user = create(:user_billy)
      #  ::Have.create!(:card_name => 'Card 1', :user => other_user)
      #  ::Have.create!(:card_name => 'Card 2', :user => @auth.user)
      #  click_link 'I Have'
      #  page.should have_content('Card 1')
      #  page.should have_content('Card 2')
      #end

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
