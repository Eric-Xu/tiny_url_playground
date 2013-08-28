require 'spec_helper'

describe "Static pages" do
	subject { page }
	let(:base_title) { "LOL.ly" }

  describe "About page" do
  	before { visit about_path }

  	it { should have_title(full_title('About')) }
  	it { should have_content('Techniques Used') }
  end
end
