class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  	helper_method :current_user

  	def current_user
  		current_user ||= User.find_by_auth_token!(search_session_and_cookies(:auth_token)) if search_session_and_cookies(:auth_token)
  	end

  	def search_session_and_cookies(key)
  		session[key] || cookies[key]
  	end

	  def transfer_urls_from_session(user)
	    if session[:url_ids]
	      session[:url_ids].each do |id|
	        url = Url.find(id)
	        url.user_id = user.id
	        url.save
	      end
	      session[:url_ids] = nil
	    end
	  end

	  def generate_token(user)
	    begin
	      user.auth_token = SecureRandom.urlsafe_base64
	    end while User.exists?(auth_token: user.auth_token)
	  end

	  def set_session_and_cookies(user)
	    if params[:remember_me]
	      cookies.permanent[:auth_token] = user.auth_token
	    else
	      session[:auth_token] = user.auth_token
	    end
	  end

	  def delete_session_and_cookies
	    reset_session # clear url_ids and auth_token
	    cookies.delete(:auth_token)
	  end
end
