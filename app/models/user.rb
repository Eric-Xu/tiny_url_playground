class User < ActiveRecord::Base
	before_save { self.email.downcase! if self.email }

	has_many :urls

	has_secure_password

	validates :password,
						password_format: true

	validates :email,
						uniqueness: true,
						length: {minimum: 3, maximum: 254},
						email_format: true
end