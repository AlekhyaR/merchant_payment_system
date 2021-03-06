class User < ApplicationRecord
  devise :registerable
  
  enum role: %i[merchant admin]
  enum status: %i[active inactive]
  
  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password
  has_many :transactions, foreign_key: :merchant_id, class_name: 'Transactions::Base', dependent: :restrict_with_exception
end
