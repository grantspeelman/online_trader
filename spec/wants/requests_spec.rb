# frozen_string_literal: true

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

  describe '/wants' do
    describe '/new GET' do
      it do
        get '/wants/new'
        expect(response).to be_success
        expect(response.body).to include('New want')
      end
    end

    describe 'POST' do
      specify 'invalid' do
        post '/wants'
        expect(response.body).to include('New want')
        expect(response.status).to eq(400)
      end
    end

    describe '/:id' do
      let(:want) { create(:want, user: current_user) }

      describe 'GET' do
        it do
          get "/wants/#{want.id}"
          expect(response).to be_success
          expect(response.body).to include(want.name)
        end
      end

      describe '/edit GET' do
        it do
          get "/wants/#{want.id}/edit"
          expect(response).to be_success
          expect(response.body).to include(want.name)
        end
      end

      describe 'PUT' do
        specify 'invalid' do
          put "/wants/#{want.id}", params: { want: { name: '' } }
          expect(response.body).to include('Editing want')
          expect(response.status).to eq(400)
        end
      end

      describe 'DELETE' do
        specify 'success' do
          delete "/wants/#{want.id}"
          expect(response).to redirect_to(wants_path)
        end
      end
    end
  end
end
