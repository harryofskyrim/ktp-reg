class User < ApplicationRecord
#	before_save { self.email = email.downcase }
#	validates :lastName, presence: true, length: { maximum: 50 }
#	validates :firstName, presence: true, length: { maximum: 50 }
#	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :occupation, presence: true
	
#	has_secure_password
#	validates :password, presence: true, length: { minimum: 6 }
end
