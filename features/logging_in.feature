Feature: Logging in
	In order to manage and save urls <business value>
	As an existing user <role>
	I want to log in <feature>

	Scenario: Unsuccessful authentication
		Given a user visits the login page
		When he submits invalid credentials
		Then he should see an error message

	Scenario: Successful authentication
		Given a user visits the login page
		And the user has an account
		When he submits valid credentials
		Then he should see the home page
		And he should see a login success message
		And he should see a log out link