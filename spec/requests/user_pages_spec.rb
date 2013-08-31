require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_title(full_title('Sign Up')) }
		it { should have_selector('h1', text: 'Howdy Stranger') }
	end

	describe "signing up" do
		before { visit signup_path }

		let(:submit) { "Sign Up" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_title(full_title('Sign Up')) }
				it { should have_notification_message("can't be blank") }
			end
		end

		describe "with valid information" do
			# before do
			# 	fill_in 'Email',						with: 'user@foo.com'
			# 	fill_in 'Password',					with: 'foobar1'
			# 	fill_in 'Confirm Password', with: 'foobar1'
			# end
			user = FactoryGirl.build(:user) # .build returns a User instance that's not saved
			before { valid_signup(user) }

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'user@foo.com') }

				it { should have_title(full_title('')) }
				it { should have_notification_message('Thank you for signing up') }
				it { should have_content(user.email) }
				it { should have_link('Log Out', href: logout_path) }
				it { should_not have_link('Log In', href: login_path) }
				it { should_not have_link('Sign Up', href: signup_path) }

				describe "the user's remember me auth_token" do
					it { expect(user.auth_token).not_to be_blank }
				end
			end
		end
	end

	describe "show page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_selector('h1', text: user.email) }
	end
end
