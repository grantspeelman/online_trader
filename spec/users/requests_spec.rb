# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'My Account', type: :request do
  before { login }

  describe '/users' do
    describe '/:id' do
      describe 'GET' do
        it 'allowed to view own user' do
          get "/users/#{current_user.to_param}"
          expect(response).to be_successful
          expect(response.body).to include('Name:')
          # should show linked services
          expect(response.body).to include('The following services are linked with this account')
        end

        it 'allowed to view another user page' do
          get "/users/#{create(:user).to_param}"
          expect(response).to be_successful
          expect(response.body).to include('Name:')
          # should not show linked services
          expect(response.body).to_not include('The following services are linked with this account')
        end
      end

      describe '/edit GET' do
        it 'allow to edit own user' do
          get "/users/#{current_user.to_param}/edit"
          expect(response).to be_successful
          expect(response.body).to include('Editing user')
        end

        it 'not allowed to edit another user' do
          get "/users/#{create(:user).to_param}/edit"
          expect(response.status).to eq(403)
        end
      end
    end

    describe 'GET' do
      specify do
        get '/users'
        expect(response).to be_successful
        expect(response.body).to include('Listing users')
      end
    end
  end
end
