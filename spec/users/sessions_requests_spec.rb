# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Session', type: :request do
  describe '/auth' do
    describe '/failure GET' do
      it 'redirects user to login' do
        get '/auth/failure'
        expect(response).to redirect_to(login_path)
        expect(flash[:error]).to be_present
      end
    end

    describe '/:provider/callback POST' do
      it 'logs you in' do
        post '/auth/developer/callback'
        # first login redirects to user edit
        expect(response).to redirect_to(edit_user_path(current_user))

        post '/auth/developer/callback'
        # second login redirects to root
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '/logout DELETE' do
    it 'returns user to root path' do
      delete '/logout'
      expect(response).to redirect_to(root_path)
    end
  end
end
