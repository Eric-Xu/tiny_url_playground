class User < ActiveRecord::Base
	has_many :urls

	has_secure_password

	validates :password,
						password_format: true

	validates :email,
						uniqueness: true,
						length: {minimum: 3, maximum: 254},
						email_format: true
end
