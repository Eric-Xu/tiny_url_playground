class Url < ActiveRecord::Base
	include Constantable

	belongs_to :user

	before_create :convert_url, :retrieve_title

	validates :original_url,
						presence: true,
						url_format: true

	def lookup_acronyms
		# definitions = []
		# converted_url.split("_").each do |acronym|
		# 	definitions << Constantable::ACRONYMNS[acronym]
		# end
		# definitions.join(", ")
		# definitions.map { |d| "'" + d + "'" }.join(", ")
		converted_url.split("_").map { |acronym| Constantable::ACRONYMNS[acronym] }.join(", ")
	end

	private
		def convert_url
			begin
				# self.converted_url = Constantable::ACRONYMNS.sample(3).join("_")
				self.converted_url = Constantable::ACRONYMNS.keys.sample(3).join("_")
			end while Url.exists?(converted_url: self.converted_url)
		end

		def retrieve_title
			doc = Nokogiri::HTML(open(self.original_url))
			self.title = doc.at_css("title").text
		end
end