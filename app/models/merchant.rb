class Merchant < ApplicationRecord

  enum status: %i[active inactive]
  has_many :transactions
end
