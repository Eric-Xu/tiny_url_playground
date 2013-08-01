class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
      set_session_and_cookies(user)
      transfer_urls_from_session(user)
      redirect_to root_url, notice: "Logged in!"
  	else
  		flash.now.alert = "Email or password is invalid."
  		render :new
  	end
  end

  def destroy
    delete_session_and_cookies
  	redirect_to root_url, notice: "Logged out!"
  end
end