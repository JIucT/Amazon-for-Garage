class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :customers
  has_many :ratings, through: :customers

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :in_stock, presence: true
end
