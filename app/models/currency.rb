class Currency < ApplicationRecord
  has_many :rates, dependent: :destroy
end
