require 'spec_helper'

describe 'Home' do

  describe "first login" do

    it "should see home page" do
      visit "/auth/google"
      page.should have_content("Home")
    end

  end

end
