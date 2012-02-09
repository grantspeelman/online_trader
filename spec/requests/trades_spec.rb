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

    describe "index" do

      it "should load page" do
        click_link 'My Trades'
        page.should have_content('My Trades')
      end

      it "should list trades" do
        grant = create(:admin_grant)
        kim = create(:user_kim)
        t1 = Trade.create!(:user => current_user,
                      :with_user => grant,
                      :user_cards => ['Card 1'],
                      :with_user_cards =>  ['Card 2'])
        t2 = Trade.create!(:user => kim,
                      :with_user => current_user,
                      :user_cards => ['Card 10','Card 12'],
                      :with_user_cards =>  ['Card 2'])
        click_link 'My Trades'
        page.should have_css("#show_trade_#{t1.id}")
        page.should have_css("#show_trade_#{t2.id}")
      end

      it "should allow paging"  do
        grant = create(:admin_grant)
        (1..100).each do |i|
          Trade.create!(:user => current_user,
                        :with_user => grant,
                        :user_cards => ['Card 1'],
                        :with_user_cards =>  ['Card 2'])
        end
        click_link 'My Trades'
        click_link 'Next'
        page.should have_content("My Trades")
      end

      it "should not list other user's trades" do
        grant = create(:admin_grant)
        kim = create(:user_kim)
        t1 =Trade.create!(:user => kim,
                      :with_user => grant,
                      :user_cards => ['Card 1'],
                      :with_user_cards =>  ['Card 2'])
        click_link 'My Trade'
        page.should_not have_css("#show_trade_#{t1.id}")
      end


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
