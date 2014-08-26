class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable
  has_many :orders
  has_many :ratings
  belongs_to :current_order, class: Order

  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  
  def is_admin?
    is_admin
  end

  def current_admin
    current_user && current_user.is_admin
  end

end
