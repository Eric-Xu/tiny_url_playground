require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_title(full_title('Sign Up')) }
		it { should have_selector('h1', text: 'Howdy Stranger') }
	end
end
