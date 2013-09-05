require 'spec_helper'

describe User do

	before do
	  @user = User.new(email: "user@foo.com",
	  								password: "foobar1",
	  								password_confirmation: "foobar1")
	end

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:auth_token) }
	it { should respond_to(:authenticate)}
	it { should respond_to(:admin) }
	it { should respond_to(:last_login) }
	it { should respond_to(:urls_count) }
	it { should respond_to(:urls) }

	it { should be_valid }
	it { should_not be_admin }

	describe "with admin attribute set to 'true'" do
		before do
			@user.save
			@user.toggle!(:admin)
		end
		it { should be_admin }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when email is too long" do
		before { @user.email = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org, example.user@foo. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

	describe "when email is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when email is mixed case" do
		let(:mixed_case_email) { "uSeR@fOo.CoM" }

		it "should be saved as all lowercase" do
			@user.email = mixed_case_email
			@user.save
			expect(@user.reload.email).to eq mixed_case_email.downcase
		end
	end

	describe "when password is not present" do
		before do
			@user = User.new(email: "user@foo.com",
											password: " ",
											password_confirmation: " ")
		end
		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "with password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should_not be_valid }
	end

	describe "with password that's too weak" do
		before { @user.password = @user.password_confirmation = "secret" }
		it { should_not be_valid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end

	describe "url associations" do
		before { @user.save }
		let!(:older_url) do
			FactoryGirl.create(:url, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_url) do
			FactoryGirl.create(:url, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right urls in the right order" do
			expect(@user.urls.to_a).to eq [newer_url, older_url]
		end

		it "should destroy associated urls" do
			urls = @user.urls.to_a
			@user.destroy
			expect(urls).not_to be_empty
			urls.each do |url|
				expect(Url.where(id: url.id)).to be_empty
				# the above line is the same as saying:
				# expect do
				# 	Url.find(url)
				# end.to raise_error(ActiveRecord::RecordNotFound)
			end
		end
	end
end