require 'spec_helper'

describe "Url pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }

	before { log_in user }

	describe "each single url" do
		let!(:u1) { FactoryGirl.create(:url, user: user, original_url: "www.foo.com") }
		before { visit urls_path }

		it { should have_selector('p.definitions.showing') }
		it { should have_selector('button.translate.hidden', visible: false) }

		describe "after loading jQuery", js: true do
			it "should hide its definitions" do
				page.find('p.definitions.hidden', visible: false).visible?.should be_false
			end

			it "should display the translate button" do
				page.find('button.translate.showing').visible?.should be_true
			end
		end

		describe "after clicking the translate button", js: true do
			before { click_button 'Translate' }

			it { should have_selector('button', text: 'HIDE') }
			it { should_not have_selector('button', text: 'TRANSLATE') }

			it "should display the definitions" do
				page.find('p.definitions.showing').visible?.should be_true
			end
		end
	end

	describe "index" do
		describe "for logged in users" do
			let!(:u1) { FactoryGirl.create(:url, user: user, original_url: "www.foo.com") }
			let!(:u2) { FactoryGirl.create(:url, user: user, original_url: "www.bar.com") }

			before { visit urls_path }

			describe "urls" do
				it { should have_content(u1.original_url) }
				it { should have_content(u1.title) }
				it { should have_content("#{u1.page_view} Page Views") }
				it { should have_selector("a[href='#{u1.converted_url}'][target='_blank']") }
				it { should have_selector('a[data-method=delete]', text: 'Delete') }
				it { should have_css('button.hidden') }
				it { should have_css('p.definitions.showing') }

				it { should have_content(u2.original_url) }
			end
		end
	end

	describe "url creation" do
		let(:submit) { "Sweet!" }

		before { visit urls_path }

		describe "with invalid format" do
			it "should not create a url" do
				expect { click_button submit }.not_to change(Url, :count)
			end

			it "renders an error message" do
				click_button submit
				page.should have_notification_message('Original url is not formatted properly.')
			end
		end

		describe "with valid format" do
			before { fill_in 'url_original_url', with: 'www.foo.com' }

			it "should create a url" do
				expect { click_button submit }.to change(Url, :count).by(1)
			end
		end
	end

	describe "destroy" do
		before do
			FactoryGirl.create(:url, user: user)
			visit urls_path
		end

		it "should delete a micropost" do
			expect { click_link 'Delete' }.to change(Url, :count).by(-1)
		end
	end
end