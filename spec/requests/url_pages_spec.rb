require 'spec_helper'

describe "Url pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }

	before { log_in user }

	describe "index" do
		describe "for logged in users" do
			let!(:u1) { FactoryGirl.create(:url, user: user, original_url: "www.foo.com") }
			let!(:u2) { FactoryGirl.create(:url, user: user, original_url: "www.bar.com") }

			before { visit urls_path }

			it { should have_title(full_title('')) }

			describe "urls" do
				it { should have_content(u1.original_url) }
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

			describe "error messages" do
				it { should have_selector('div.notifications', 'not formatted properly') }
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

	describe "show" do

	end
end