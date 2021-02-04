class Merchant < ApplicationRecord

  enum status: %i[active inactive]
  has_many :transactions, class_name: 'Transactions::Base', dependent: :restrict_with_exception
end
