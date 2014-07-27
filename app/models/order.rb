class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :credit_card
  belongs_to :billing_address, class: Address
  belongs_to :shipping_address, class: Address 
  has_many :order_items
  has_many :books, through: :order_items


  validates :total_price, presence: true
  validates :completed_at, presence: true
  validates :state, presence: true
end
