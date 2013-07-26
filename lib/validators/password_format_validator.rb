class PasswordFormatValidator < ActiveModel::EachValidator
	def validate_each(object, attribute, value)
		object.errors[attribute] << (
			options[:message] || "needs to be at least 6 characters and include one number and one letter."
		) unless
			value =~ /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/
	end
end