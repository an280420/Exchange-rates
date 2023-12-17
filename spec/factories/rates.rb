FactoryBot.define do
  factory :rate do
    value { 100.0 }
    date { Date.today - 7.days }
    currency
  end
end