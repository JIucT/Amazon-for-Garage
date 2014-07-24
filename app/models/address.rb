class Address < ActiveRecord::Base
  validates :address1, presence: true
  validates :address2, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :mobile_number, presence: true
end
