require 'spec_helper'

describe UrlsController do
	# let(:url) { FactoryGirl.create(:url) }

	describe "when creating a url with Ajax" do
		it "should increment the Url count" do
			expect do
				xhr :post, :create, url: { original_url: 'www.foo.com' }
			end.to change(Url, :count).by(1)
		end

		it "should respond with success" do
			xhr :post, :create, url: { original_url: 'www.foo.com' }
			expect(response).to be_success
		end
	end

	describe "when destroying a url with Ajax" do
		let!(:url) { Url.create(original_url: 'www.bar.com') }

		it "should decrement the Url count" do
			expect do
				xhr :delete, :destroy, id: url.id
			end.to change(Url, :count).by(-1)
		end

		it "should respond with success" do
			xhr :delete, :destroy, id: url.id
			expect(response).to be_success
		end
	end

	# describe "when showing a url with Ajax" do
	# 	let!(:url) { Url.create(original_url: 'www.baz.com') }
	# 	subject { url }
	# 	before { xhr :get, :show, id: url.id }

	# 	it "redirect to original url page" do
	# 		response.should redirect_to('http://www.baz.com')
	# 	end

	# 	its("page_view") { should eq(1) }
	# end
end