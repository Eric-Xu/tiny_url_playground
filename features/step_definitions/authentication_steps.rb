Given /^a user visits the login page$/ do
	visit login_path
end

When /^he submits invalid credentials$/ do
	click_button 'Log In'
end

Then /^he should see an error message$/ do
	expect(page).to have_selector('div.notifications', text: 'Email or password is invalid.')
end

Given /^the user has an account$/ do
  @user = User.create(email: 'user@foo.com',
  										password: 'foobar1',
  										password_confirmation: 'foobar1')
end

When /^he submits valid credentials$/ do
	fill_in 'Email', 		with: @user.email
	fill_in 'Password', with: @user.password
	click_button 'Log In'
end

Then /^he should see the home page$/ do
	expect(page.current_path).to eq(root_path)
end

Then /^he should see a login success message$/ do
	expect(page).to have_selector('div.notifications', text: 'Logged in')
end

Then /^he should see a log out link$/ do
	expect(page).to have_link('Log Out', href: logout_path)
end