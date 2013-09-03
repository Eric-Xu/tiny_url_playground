include ApplicationHelper

RSpec::Matchers.define :have_notification_message do |msg|
	match do |page|
		expect(page).to have_selector('div.notifications', text: msg)
	end
end

def valid_signup(user)
	fill_in 'Email', 						with: user.email
	fill_in 'Password', 				with: user.password
	fill_in 'Confirm Password', with: user.password_confirmation
end

def log_in(user, options={})
	if options[:no_capybara]
		# log in when not using Capybara
		# necessary for get, post, patch, and delete
    # transfer_urls_from_session(user)
    # modified set_session_and_cookies(user)
    # set_session_and_nonpermanent_cookies(user)
	else
		visit login_path
		fill_in 'Email', 		with: user.email
		fill_in 'Password', with: user.password
		click_button 'Log In'
	end
end

def set_session_and_nonpermanent_cookies(user)
  if params[:remember_me]
    cookies[:auth_token] = user.auth_token
  else
    session[:auth_token] = user.auth_token
  end
end