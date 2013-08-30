class User < ActiveRecord::Base
	before_save { self.email.downcase! if self.email }
  before_create :initialize_last_login

	has_many :urls

	has_secure_password

	validates :password,
						password_format: true

	validates :email,
						uniqueness: { case_sensitive: false },
						length: { maximum: 50 },
						email_format: true

	private
    def initialize_last_login
      self.last_login = Time.now
    end
end