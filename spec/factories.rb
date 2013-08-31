FactoryGirl.define do
	factory :user do
		email			'user@foo.com'
		password  'foobar1'
		password_confirmation 'foobar1'
		auth_token 'aaabbbcccdddeeefffggg'
	end
end