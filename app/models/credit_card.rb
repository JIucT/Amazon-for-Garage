class CreditCard < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :number, presence: true
  validates :expiration_date, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
end
