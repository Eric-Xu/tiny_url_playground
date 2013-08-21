class Url < ActiveRecord::Base
	include Constantable
	require 'open-uri'

	belongs_to :user

	before_create :convert_url, :check_url_protocol, :retrieve_title

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

    def check_url_protocol
    	temp_url = original_url
      if /\Ahttp/.match(temp_url)
        unless /\A(http|https):\/\/www/.match(temp_url)
          self.original_url = "http://www.#{temp_url}"
        end
        self.original_url = temp_url
      else
        self.original_url = "http://#{temp_url}"
      end
    end

		def retrieve_title
			begin
				doc = Nokogiri::HTML(open(self.original_url))
				doc_title = doc.at_css("title").text
				self.title = doc_title.blank? ? self.original_url : doc_title
			rescue
				self.title = self.original_url
			end
		end
end