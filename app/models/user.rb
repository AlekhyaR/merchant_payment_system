class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable
  
  enum role: %i[merchant admin]
  enum status: %i[active inactive]
  
  validates :name, uniqueness: true, presence: true
  has_secure_password

  def generate_jwt
    JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secrets.secret_key_base)
  end
end
