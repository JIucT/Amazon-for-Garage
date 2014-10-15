class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :credit_card
  belongs_to :billing_address, class: Address
  belongs_to :shipping_address, class: Address 
  has_many :order_items
  has_many :books, through: :order_items


  validates :total_price, presence: true
  validates :shipping_type, presence: true
  validates :number, presence: true
  validates :completed_at, presence: true

  after_initialize :set_defaults

  def set_defaults
    self.number ||= Random::rand().to_s[2..11]
    self.completed_at ||= Date.today
  end
end
