require 'spec_helper'

describe "Static pages" do
	subject { page }
	let(:base_title) { "LOL.ly" }

	it "should have the right links on the home page layout" do
		visit root_path
		click_link "What's under the hood?"
  	expect(page).to have_title(full_title('About'))
  	click_link "Log In"
  	expect(page).to have_title(full_title('Log In'))
  	click_link "Smile and sign up"
  	expect(page).to have_title(full_title('Sign Up'))
	end

  describe "About page" do
  	before { visit about_path }

  	it { should have_title(full_title('About')) }
  	it { should have_selector('h1', text: 'Techniques Used') }
  end
end
