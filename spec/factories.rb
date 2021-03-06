FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "user_#{n}@foo.com" }
		password  'foobar1'
		password_confirmation 'foobar1'

		factory :admin do
			admin true
		end
	end

	factory :url do
		original_url 'www.foo.com'
		user
	end
end