# LOL.ly: a url sweetener

LOL.ly is a Rails 4.0 app featuring a responsive layout and progressive enhancement for Javascript. Testing is done through RSpec for models, controllers, and helpers, while Capybara and PhantomJS is also used during high-level integration testing.

The app allows users to enter a url and converts it into a random triplet of acronyms. It starts with a temporary guest account. If a user signs up during his/her session, all urls get transferred over from the guest user to the newly created account.

#### Front End
  + HTML5 elements and form validations
  + CSS transitions
  + SCSS mixins, extends, and variables
  + Coffeescript
  + jQuery
  + Ajax
  + Responsive design
  + Progressive enhancement with Javascript

#### Back End
  + Rails 4.0
  + Authentication from scratch
  + Counter cache column
  + Pagination via will_paginate
  + Screen scraping using Nokogiri
  + Exception handling through Rack middleware

#### Testing
  + RSpec
  + Capybara
  + PhantomJS
  + FactoryGirl

#### Check out the site live here: [LOL.ly]

  [LOL.ly]: https://lolly.herokuapp.com

---

Run these commands to try it out:

> `bundle`
> `cp config/application.example.yml config/application.yml`
> `rake db:setup`
> `rails s`

*Requires Rails 4.0.0 and Ruby 2.0.0 or later to run.*