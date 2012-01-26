require 'spec_helper'

describe "Trades" do

  def current_user
    @auth.user
  end

  describe "user" do

    before(:each) do
      @auth = create(:auth_billy)
      login_with_oauth(@auth)
    end

    describe "create" do

      it "should create a trade" do
        other_user = create(:user_kim)
        click_link 'My Trades'
        click_link 'Add Trade'
        fill_in 'Trade with', :with => other_user.ign
        fill_in 'trade_user_cards_0', :with => "My Great Card"
        fill_in 'trade_with_user_cards_0', :with => "Great Card I Want"
        click_button 'Create Trade'
        page.should have_content("Trade was successfully created.")
        @auth.user.should have(1).trades
      end

      it "should not create a trade without a valid trade partner" do
        click_link 'My Trades'
        click_link 'Add Trade'
        fill_in 'Trade with', :with => "Somebody"
        click_button 'Create Trade'
        page.should_not have_content("Trade was successfully created.")
        page.should have_content("With user does not exist")
      end

    end

  end
end
