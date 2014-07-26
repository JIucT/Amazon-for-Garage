class CreditCard < ActiveRecord::Base
  belongs_to :customer
  has_many :orders

  validates :number, presence: true
  validates :expiration_date, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
end
