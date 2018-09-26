# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Haves', type: :request do
  before { login }

  describe '/users/:id/haves GET' do
    it 'allowed to view your own haves' do
      have = create(:have, user: current_user)
      get "/users/#{current_user.to_param}/haves"
      expect(response).to be_successful
      expect(response.body).to include('My haves')
      expect(response.body).to include(have.name)
    end

    it 'allowed to view another user page' do
      other_user = create(:user)
      have = create(:have, user: other_user)
      get "/users/#{other_user.to_param}/haves"
      expect(response).to be_successful
      expect(response.body).to include("#{other_user.name} haves")
      expect(response.body).to include(have.name)
    end
  end

  describe '/haves' do
    describe '/new GET' do
      it do
        get '/haves/new'
        expect(response).to be_successful
        expect(response.body).to include('New have')
      end
    end

    describe 'POST' do
      specify 'invalid' do
        post '/haves'
        expect(response.body).to include('New have')
        expect(response.status).to eq(400)
      end
    end

    describe '/:id' do
      let(:have) { create(:have, user: current_user) }

      describe 'GET' do
        it do
          get "/haves/#{have.id}"
          expect(response).to be_successful
          expect(response.body).to include(have.name)
        end
      end

      describe '/edit GET' do
        it do
          get "/haves/#{have.id}/edit"
          expect(response).to be_successful
          expect(response.body).to include(have.name)
        end
      end

      describe 'PUT' do
        specify 'invalid' do
          put "/haves/#{have.id}", params: { have: { name: '' } }
          expect(response.body).to include('Editing have')
          expect(response.status).to eq(400)
        end
      end

      describe 'DELETE' do
        specify 'success' do
          delete "/haves/#{have.id}"
          expect(response).to redirect_to(haves_path)
        end
      end
    end
  end
end
