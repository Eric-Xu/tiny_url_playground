class User < ActiveRecord::Base
	before_save { self.email = email.downcase if self.email }
	before_create :generate_token, :initialize_last_login

	has_many :urls, dependent: :destroy

	has_secure_password

	validates :password,
						password_format: true

	validates :email,
						uniqueness: { case_sensitive: false },
						length: { maximum: 50 },
						email_format: true

	private
	  def generate_token
	    begin
	      self.auth_token = SecureRandom.urlsafe_base64
	    end while User.exists?(auth_token: self.auth_token)
	  end

    def initialize_last_login
      self.last_login = Time.now
    end
end