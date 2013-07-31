class User < ActiveRecord::Base
	has_many :urls

	has_secure_password

	# before_create :generate_token

	validates :password,
						password_format: true

	validates :email,
						uniqueness: true,
						length: {minimum: 3, maximum: 254},
						email_format: true

	# private
 #  # refactor to share with login
	# 	def generate_token
	# 		begin
	# 			self[:auth_token] = SecureRandom.urlsafe_base64
	# 		end while User.exists?(auth_token: self[:auth_token])
	# 	end
end