require 'rails_helper'

RSpec.describe 'Haves', type: :request do
  before { login }

  describe '/users/:id/haves GET' do
    it 'allowed to view your own haves' do
      have = create(:have, user: current_user)
      get "/users/#{current_user.to_param}/haves"
      expect(response).to be_success
      expect(response.body).to include('My haves')
      expect(response.body).to include(have.name)
    end

    it 'allowed to view another user page' do
      other_user = create(:user)
      have = create(:have, user: other_user)
      get "/users/#{other_user.to_param}/haves"
      expect(response).to be_success
      expect(response.body).to include("#{other_user.name} haves")
      expect(response.body).to include(have.name)
    end
  end

  describe '/haves' do
    describe '/new GET' do
      it do
        get '/haves/new'
        expect(response).to be_success
        expect(response.body).to include('New have')
      end
    end

    describe '/:id' do
      let(:have) { create(:have, user: current_user) }

      describe 'GET' do
        it do
          get "/haves/#{have.id}"
          expect(response).to be_success
          expect(response.body).to include(have.name)
        end
      end

      describe '/edit GET' do
        it do
          get "/haves/#{have.id}/edit"
          expect(response).to be_success
          expect(response.body).to include(have.name)
        end
      end
    end
  end
end
