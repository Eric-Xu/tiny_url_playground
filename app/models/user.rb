class User < ActiveRecord::Base
	before_save { self.email.downcase! if self.email }

	has_many :urls

	has_secure_password

	validates :password,
						password_format: true

	validates :email,
						uniqueness: { case_sensitive: false },
						length: { maximum: 50 },
						email_format: true
end