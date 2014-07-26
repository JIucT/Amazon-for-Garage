class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings

  validates :password_digest, presence: true, length: { in: 6..20 }
  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  has_secure_password
end
