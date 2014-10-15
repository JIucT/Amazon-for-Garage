class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable 
  has_many :orders, dependent: :destroy
  has_many :ratings
  belongs_to :billing_address, class: Address, dependent: :destroy
  belongs_to :shipping_address, class: Address, dependent: :destroy 

  validates :email, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  devise :omniauthable, :omniauth_providers => [:facebook]
  
  def is_admin?
    is_admin
  end

  def current_admin
    current_user && current_user.is_admin
  end

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.firstname = auth.info.first_name   # assuming the user model has a name
      user.lastname = auth.info.last_name

    #  user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.firstname = data["first_name"] if user.firstname.blank?
        user.lastname = data["last_name"] if user.lastname.blank?
      end
    end
  end
end
