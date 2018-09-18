# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Have, type: :model do
  describe 'Validations' do
    it 'requires a name' do
      subject.name = ''
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to_not be_empty

      subject.name = 'name'
      subject.valid?
      expect(subject.errors[:name]).to be_empty
    end

    describe 'requires a unique name' do
      let!(:existing_have) { create(:have, name: 'name') }

      before do
        subject.user_id = existing_have.user_id
        subject.amount = 1
      end

      it 'when new' do
        subject.name = 'name'
        expect(subject).to_not be_valid
        expect(subject.errors[[:name, :user_id]]).to_not be_empty
      end

      it 'when updating' do
        subject.name = 'other'
        subject.save

        subject.name = 'name'
        expect(subject).to_not be_valid
        expect(subject.errors[[:name, :user_id]]).to_not be_empty
      end
    end

    describe 'requires a valid amount' do
      it 'requires a integer' do
        subject.amount = 'one'
        expect(subject).to_not be_valid
        expect(subject.errors[:amount]).to_not be_empty

        subject.amount = '1'
        subject.valid?
        expect(subject.errors[:amount]).to be_empty
      end

      it 'requires to be positive number' do
        subject.amount = '0'
        expect(subject).to_not be_valid
        expect(subject.errors[:amount]).to_not be_empty

        subject.amount = '-1'
        expect(subject).to_not be_valid
        expect(subject.errors[:amount]).to_not be_empty
      end
    end
  end

  describe 'wants' do
    let!(:existing_user) { create(:user) }

    before do
      subject.user = existing_user
    end

    it 'returns matches based on name' do
      want1 = create(:want, name: 'Greninja')
      want2 = create(:want, name: 'Greninja')
      create(:want, name: 'Arceus')
      subject.name = 'Greninja'

      expect(subject.wants).to contain_exactly(want1,want2)
    end

    it 'ignores own wants' do
      create(:want, name: 'Greninja', user: existing_user)
      subject.name = 'Greninja'

      expect(subject.wants).to be_empty
    end

    it 'ignores if name does not match' do
      create(:want, name: 'Arceus')
      subject.name = 'Greninja'

      expect(subject.wants).to be_empty
    end
  end
end
