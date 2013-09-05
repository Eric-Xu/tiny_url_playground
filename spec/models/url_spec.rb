require 'spec_helper'

describe Url do
	let(:user) { FactoryGirl.create(:user) }
	before { @url = user.urls.build(original_url: 'www.foo.com', user_id: user.id) }

	subject { @url }

	it { should respond_to(:original_url) }
	it { should respond_to(:converted_url) }
	it { should respond_to(:title) }
	it { should respond_to(:page_view) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when original_url is not present" do
		before { @url.original_url = "" }
		it { should_not be_valid }
	end

	describe "when url format is invalid" do
		it "should be invalid" do
			#http://wwww.foo.com http://www.foo
			invalid_urls = %w[htttp://www.foo.com foo,com www,bar,com foo..com foobar]
			invalid_urls.each do |invalid_url|
				@url.original_url = invalid_url
				expect(@url).not_to be_valid
			end
		end
	end

	describe "when url format is valid" do
		it "should be valid" do
			valid_urls = %w[https://www.foobar.com/baz  https://foobar.com/baz
											http://www.foobar.com/baz		http://foobar.com/baz
											https://www.foobar.com  		https://foobar.com
											http://www.foobar.com   		http://foobar.com
											www.foobar.com							foobar.com]
			valid_urls.each do |valid_url|
				@url.original_url = valid_url
				expect(@url).to be_valid
			end
		end
	end
end