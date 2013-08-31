require 'spec_helper'

describe ApplicationHelper do

	describe "full_title method" do
		it "should include the page title" do
			expect(full_title('about')).to match(/about/)
		end

		it "should include the base title" do
			expect(full_title('about')).to match(/^|LOL.ly/)
		end

		it "should not include a bar for the home page" do
      expect(full_title("")).not_to match(/\|/)
		end
	end
end