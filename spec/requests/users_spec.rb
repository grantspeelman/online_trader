require 'spec_helper'

describe "Users" do

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
          click_link 'Users'
          page.should have_content('Listing users')
        end

    end

    describe "create" do

        it "should not be able to access create page" do
          # Run the generator again with the --webrat flag if you want to use webrat methods/
          visit '/users/new'
          page.should have_content('You are not authorized to access this page.')
        end

    end

    describe "update" do

        it "should be able to update account" do
          # Run the generator again with the --webrat flag if you want to use webrat methods/
          click_link 'My Account'
          click_link 'Edit User'
          fill_in 'IGN', :with => 'RubyLight'
          click_button 'Update User'
          page.should have_content('User was successfully updated.')
        end

        it "should allow access to another user's edit page" do
          # Run the generator again with the --webrat flag if you want to use webrat methods/
          other_user = create(:admin_grant)
          visit "/users/#{other_user.id}/edit"
          page.should have_content('You are not authorized to access this page.')
        end

    end

  end
end
