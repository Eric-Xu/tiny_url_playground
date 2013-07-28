class Url < ActiveRecord::Base
	include Constantable

	belongs_to :user

	before_create :convert_url

	validates :original_url,
						presence: true,
						url_format: true

	HACRONYMNS = { "AFC" => "Away From Computer",
								 "LOL" => "Laughing Out Loud",
								 "OMG" => "Oh My God",
								 "ADR" => "Address",
								 "AFAP" => "As Far As Possible" }

	private
		def convert_url
			self.converted_url = Constantable::ACRONYMNS.sample(3).join("_")
		end
end