include ApplicationHelper

RSpec::Matchers.define :have_notification_message do |msg|
	match do |page|
		expect(page).to have_selector('div.notifications', text: msg)
	end
end

def valid_login(user)
	fill_in 'Email', 		with: user.email
	fill_in 'Password', with: user.password
	click_button 'Log In'
end

def valid_signup(user)
	fill_in 'Email', 						with: user.email
	fill_in 'Password', 				with: user.password
	fill_in 'Confirm Password', with: user.password_confirmation
end