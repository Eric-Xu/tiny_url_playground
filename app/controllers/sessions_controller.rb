class SessionsController < ApplicationController
  # before_action :generate_token, only: [:new, :create]

  # def generate_token
  #   begin

  #   end while User.exists?()
  # end

  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])

      if params[:remember_me] # refactor along with users#new
        cookies.permanent[:auth_token] = user.auth_token
      else
        session[:auth_token] = user.auth_token
      end
      # session[:user_id] = user.id
      transfer_urls_from_session(user)

      redirect_to root_url, notice: "Logged in!"
  	else
  		flash.now.alert = "Email or password is invalid."
  		render :new
  	end
  end

  def destroy
    reset_session # refactor along with users#new
    cookies.delete(:auth_token)
  	redirect_to root_url, notice: "Logged out!"
  end
end
