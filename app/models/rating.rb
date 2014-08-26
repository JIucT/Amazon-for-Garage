class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :mark, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
