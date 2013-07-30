class Url < ActiveRecord::Base
	include Constantable

	belongs_to :user

	before_create :convert_url

	validates :original_url,
						presence: true,
						url_format: true

	def lookup_acronyms
		definitions = []
		self.converted_url.split("_").each do |acronym| # self is not needed?
			definitions << Constantable::ACRONYMNS[acronym]
		end
		definitions.join(", ")
		# definitions.map { |d| "'" + d + "'" }.join(", ")
	end

	private
		def convert_url
			# self.converted_url = Constantable::ACRONYMNS.sample(3).join("_")
			self.converted_url = Constantable::ACRONYMNS.keys.sample(3).join("_")
		end
end