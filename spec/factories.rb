FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "user_#{n}@foo.com" }
		password  'foobar1'
		password_confirmation 'foobar1'
		auth_token 'aaabbbcccdddeeefffggg'
	end
end