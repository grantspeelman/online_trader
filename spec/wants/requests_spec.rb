require 'rails_helper'

RSpec.describe 'Wants', type: :request do
  before { login }

  describe '/users/:id/wants GET' do
    it 'allowed to view your own wants' do
      want = create(:want, user: current_user)
      get "/users/#{current_user.to_param}/wants"
      expect(response).to be_success
      expect(response.body).to include('My wants')
      expect(response.body).to include(want.name)
    end

    it 'allowed to view another user page' do
      other_user = create(:user)
      want = create(:want, user: other_user)
      get "/users/#{other_user.to_param}/wants"
      expect(response).to be_success
      expect(response.body).to include("#{other_user.name} wants")
      expect(response.body).to include(want.name)
    end
  end
end
