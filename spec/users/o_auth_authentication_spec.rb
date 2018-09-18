# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OAuthAuthentication do
  describe '.create_from_hash' do
    subject { OAuthAuthentication }

    specify 'creates new auth and user' do
      hash = { name: 'Morsel', uid: 'test', provider: 'test' }
      record = subject.create_from_hash(hash)
      expect(record).to be_persisted
      expect(record).to be_a(OAuthAuthentication)
      expect(record.user).to be_persisted
      expect(record.user).to be_a(User)
      expect(record.user.name).to eq('Morsel')
    end

    specify 'links to existing user' do
      existing_user = create(:user, name: 'George')
      hash = { name: 'Morsel', uid: 'test', provider: 'test' }
      record = subject.create_from_hash(hash, existing_user)
      expect(existing_user.reload.name).to eq('George')
      expect(record.user).to eq(existing_user)
    end
  end
end
