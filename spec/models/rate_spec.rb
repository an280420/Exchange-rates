require 'rails_helper'

RSpec.describe Rate, type: :model do
  describe 'factory' do
    it 'is valid' do
      rate = build(:rate)
      expect(rate).to be_valid
    end
  end
end
