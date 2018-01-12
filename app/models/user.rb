class User < ApplicationRecord
#	has_many :memberships, :foreign_key => :user_id
#  has_many :teams, :through => :memberships
	has_and_belongs_to_many :teams
	
  before_save { self.email = email.downcase }
  validates :lastName, presence: true, length: { maximum: 50 }
  validates :firstName, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :occupation, presence: true
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, :if => :password
  
  def User.digest(string)
	  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	  BCrypt::Engine.cost
	  BCrypt::Password.create(string, cost: cost)
  end
end
