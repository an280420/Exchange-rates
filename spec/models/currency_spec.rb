require 'rails_helper'

RSpec.describe Currency, type: :model do
  it 'is valid with valid attributes' do
    currency = build(:currency)
    expect(currency).to be_valid
  end
end
