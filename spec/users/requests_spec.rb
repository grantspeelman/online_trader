require 'rails_helper'

RSpec.describe 'My Account', type: :request do
  before { login }

  describe '/users' do
    describe '/:id' do
      it 'allow to view own page' do
        get "/users/#{current_user.to_param}"
        expect(response.body).to include('Details')
        expect(response.body).to include('The following services are linked with this account')
      end

      it 'allow to view another user page' do
        get "/users/#{create(:user).to_param}"
        expect(response.body).to include('Details')
        expect(response.body).to_not include('The following services are linked with this account')
      end
    end
  end
end
