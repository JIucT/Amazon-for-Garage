class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings
  has_attached_file :cover, styles: { medium: "220x220#" }, :default_url => "default.png"

  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
  validates :author_id, presence: true
  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :in_stock, presence: true
end
