require 'spec_helper'

describe 'Home' do

  describe "first login" do

    it "should send you to edit page to add IGN" do
      visit "/auth/google"
      page.should have_content("Editing user")
      page.should have_content("Before using Yu-gi-oh Online Trader you have to set your IGN")
    end

    it "should not allow you to browse to any other page unless you set your IGN" do
      visit "/auth/google"
      click_link 'My Wants'
      page.should have_content("Editing user")
      page.should have_content("Before using Yu-gi-oh Online Trader you have to set your IGN")
      click_link 'I Have'
      page.should have_content("Editing user")
      page.should have_content("Before using Yu-gi-oh Online Trader you have to set your IGN")
      click_link 'My Trades'
      page.should have_content("Editing user")
      page.should have_content("Before using Yu-gi-oh Online Trader you have to set your IGN")
    end

  end

end
