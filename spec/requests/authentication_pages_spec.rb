require 'spec_helper'

describe "Authentication" do
	subject { page }

	describe "login page" do
		before { visit login_path }

		it { should have_title(full_title('Log In')) }
		it { should have_selector('h1', text: 'Welcome back. You rock!') }
	end

	describe "logging in" do
		before { visit login_path }

		describe "with invalid information" do
			before { click_button 'Log In' }

			it { should have_title(full_title('Log In')) }
			it { should have_notification_message('Email or password is invalid.') }
		end

		describe "with valid credentials" do
			let(:user) { FactoryGirl.create(:user) } # .create returns a saved User instance
      before { log_in user }

      its(:current_path) { should eq(root_path) }
			it { should have_notification_message('Logged in') }
			it { should have_content(user.email) }
			it { should have_link('Log Out', href: logout_path) }
			it { should_not have_link('Log In', href: login_path) }
			it { should_not have_link('Smile and sign up', href: signup_path) }

			describe "followed by logging out" do
				before { click_link 'Log Out' }
				it { should have_link('Log In') }
			end
		end
	end

	describe "authorization" do
		describe "as non-admin users" do
			let(:user) { FactoryGirl.create(:user) }
			let(:non_admin) { FactoryGirl.create(:user) }
			before { log_in non_admin, no_capybara: true }

			describe "submitting a DELETE request to the Users#destroy action" do
				before { delete user_path(user) }
				specify { expect(response).to redirect_to(root_url) }
			end

			describe "in the Users controller" do
				describe "visiting the user index" do
					before { get users_path } # use rspec's get instead of capybara's visit
					specify { expect(response).to redirect_to(root_url) }
				end

				describe "visiting a user show page" do
					before { get user_path(user) }
					specify { expect(response).to redirect_to(root_url) }
				end
			end
		end
	end
end
