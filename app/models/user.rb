class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable
  has_many :orders
  has_many :ratings

 # validates :password_digest, presence: true, length: { in: 6..20 }
  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  
  def is_admin?
    is_admin
  end
end
