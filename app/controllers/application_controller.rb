class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
  end

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

	  def render_error(exception)
	  	logger.info "Status: 500\nSystem Error: Tried to access '#{request.fullpath}'.\n#{exception.class} error was raised for path.\n#{exception.message}"
			render template: 'errors/500', layout: 'layouts/application', status: 500
	  end
end