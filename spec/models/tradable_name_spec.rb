# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/tradable_name'
require_relative '../../app/models/blank'
require_relative '../../app/models/exceptional'

RSpec.describe TradableName do
  describe 'usage' do
    it 'can be set and used' do
      name = described_class.new('Pichu')
      expect(name.to_s).to eq('Pichu')
    end

    it 'can be compared' do
      expect(described_class.new('Arceus')).to eq(described_class.new('Arceus'))
      expect(described_class.new('Mew')).to_not eq(described_class.new('Pikachu'))
    end
  end

  describe 'invalid' do
    it 'will not accept blank values' do
      expect { described_class.new(nil) }.to raise_error(ArgumentError)
      expect { described_class.new('') }.to raise_error(ArgumentError)
    end

    it 'will not accept other class types' do
      expect { described_class.new(other: true) }.to raise_error(ArgumentError)
      expect { described_class.new(['not']) }.to raise_error(ArgumentError)
    end
  end

  describe 'can be used in sequel queries' do
    it 'can be used find records' do
      want = create(:want, name: 'hello')
      tradable_name = TradableName('hello')
      expect(Want[{ name: tradable_name }]).to eq(want)
    end
  end

  describe '.cast' do
    it 'can load' do
      loaded_name = TradableName.cast('Greninja')
      expect(loaded_name).to be_a(described_class)
      expect(loaded_name).to_not be_exceptional

      expect(loaded_name).to eq('Greninja')
    end

    it 'loads nil as Blank value' do
      value = TradableName.cast(nil)
      expect(value).to be_a(Blank)
      expect(value).to be_blank
    end

    it 'loads empty string as Blank value' do
      value = TradableName.cast('')
      expect(value).to be_a(Blank)
      expect(value).to be_blank
    end
  end
end
