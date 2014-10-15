class Address < ActiveRecord::Base
  validates :address1, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :zip_code, presence: true
end
