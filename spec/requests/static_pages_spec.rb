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

  describe "banner ring before clicking", js: true do
    it "should show the default content" do
      within ('div#ring_front') do
        page.should have_content('LOL')
      end

      within ('div#ring_rear') do
        page.should have_selector('h2.showing')
        page.should have_selector('p#front_msg.showing')
        page.should have_selector('p#rear_msg.hidden', visible: false)
        page.should have_selector('p#ring_def.hidden', visible: false)
      end
    end
  end

  describe "banner ring after clicking", js: true do
    before { page.find('div#ring_rear').trigger('click') }
    # did not use node.click because another element is covering the target

    it "should show the new content" do
      within ('div#ring_rear') do
        page.should have_selector('h2.showing')
        page.should have_selector('p#ring_def.showing')
        page.should have_selector('p#rear_msg.showing')
        page.should have_selector('p#front_msg.hidden', visible: false)
        # puts page.find('p#rear_msg.showing').text
      end
    end
  end
end