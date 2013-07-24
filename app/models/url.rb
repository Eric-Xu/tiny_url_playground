class Url < ActiveRecord::Base
	before_create :convert_url

	validates :original_url,
	          :presence => true,
	          :format => { with: /\A((http|https):\/\/|)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix }

	ACRONYMNS = ["*$", "**//", ",!!!!", "02", "10Q", "AFC", "LOL", "OMG"]

	private
		def convert_url
			self.converted_url = "lol.ly/" + ACRONYMNS.sample(3).join("_")
		end
end