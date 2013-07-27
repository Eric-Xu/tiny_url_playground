class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  	helper_method :current_user

  	def current_user
  		current_user ||= User.find(session[:user_id]) if session[:user_id]
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
end
