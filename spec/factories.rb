FactoryGirl.define do
	factory :user do
		email			'user@foo.com'
		password  'foobar1'
		password_confirmation 'foobar1'
	end
end