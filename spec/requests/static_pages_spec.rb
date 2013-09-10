require 'spec_helper'

describe "Static pages" do
  subject { page }

  before { visit root_path }

  it "should have the right links on the home page layout" do
    click_link "What's under the hood?"
    expect(page).to have_title(full_title('About'))
    click_link "Log In"
    expect(page).to have_title(full_title('Log In'))
    click_link "Smile and sign up"
    expect(page).to have_title(full_title('Sign Up'))
  end

  describe "navigation header", js: true do
    describe "for mobile devices" do
      before { page.driver.resize 320, 480 }

      it { should have_selector('ul.hidden', visible: false) }

      it "should display the nav menu link" do
        page.find('a#nav_menu').visible?.should be_true
      end

      describe "clicking the nav menu" do
        it "should show the dropdown links" do
          click_link 'Menu'
          page.find(:xpath, "//a[@href='/signup']").visible?.should be_true
          page.find(:xpath, "//a[@href='/login']").visible?.should be_true
        end
      end
    end

    describe "for regular screens" do
      it { should have_css('ul.showing') }
    end
  end
end