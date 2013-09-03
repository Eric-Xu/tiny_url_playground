FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "user_#{n}@foo.com" }
		password  'foobar1'
		password_confirmation 'foobar1'
		sequence(:auth_token) { |n| "aaabbbcccdddeeefffggg#{n}" }

		factory :admin do
			admin true
		end
	end
end