# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/tradable_amount'
require_relative '../../app/models/blank'
require_relative '../../app/models/exceptional'

RSpec.describe TradableAmount do
  describe 'usage' do
    it 'can be set and used' do
      amount = described_class.new(1)
      expect(amount.to_s).to eq('1')
      expect(amount.to_i).to eq(1)
    end

    it 'can be set using a string' do
      amount = described_class.new('2')
      expect(amount.to_s).to eq('2')
      expect(amount.to_i).to eq(2)
    end

    it 'can be compared' do
      expect(described_class.new('3')).to eq(described_class.new(3))
      expect(described_class.new('31')).to_not eq(described_class.new(30))
    end
  end

  describe 'invalid' do
    it 'must be a integer value' do
      expect { described_class.new('asdasd') }.to raise_error(ArgumentError)
      expect { described_class.new('1.10') }.to raise_error(ArgumentError)
      expect { described_class.new(1.10) }.to raise_error(ArgumentError)
    end

    it 'must be a postive integer' do
      expect { described_class.new('0') }.to raise_error(ArgumentError)
      expect { described_class.new(0) }.to raise_error(ArgumentError)
      expect { described_class.new(-1) }.to raise_error(ArgumentError)
      expect { described_class.new('-1') }.to raise_error(ArgumentError)
    end

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
      want = create(:want, amount: 101)
      tradable_amount = TradableAmount('101')
      expect(Want[{ amount: tradable_amount }]).to eq(want)
    end
  end

  describe '.cast' do
    it 'can load' do
      loaded_amount = TradableAmount.cast('100')
      expect(loaded_amount).to be_a(described_class)
      expect(loaded_amount).to_not be_exceptional

      expect(loaded_amount).to eq(100)
    end

    it 'loads nil as Blank value' do
      value = TradableAmount.cast(nil)
      expect(value).to be_a(Blank)
      expect(value).to be_blank
    end

    it 'loads empty string as Blank value' do
      value = TradableAmount.cast('')
      expect(value).to be_blank
    end

    it 'loads values below 1 as exceptional' do
      value = TradableAmount.cast(0)
      expect(value).to be_exceptional
      expect(value.message).to eq('0 is less than 1')

      value = TradableAmount.cast('-1')
      expect(value).to be_exceptional
      expect(value.message).to eq('-1 is less than 1')
    end
  end
end
