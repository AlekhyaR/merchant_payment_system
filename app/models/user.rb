class User < ApplicationRecord
  enum role: %i[merchant admin]
  
  belongs_to :merchant, foreign_key: :account_id

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
