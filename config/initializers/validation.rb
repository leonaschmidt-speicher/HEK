module ActiveModel
  module Validations
    class PresenceValidator < EachValidator
      def validate record
        attributes.each do |attribute|
          value = record.send("#{attribute}_before_type_cast") || record.read_attribute_for_validation(attribute)
          next if (value.nil? and options[:allow_nil]) || (value.blank? and options[:allow_blank])
          validate_each record, attribute, value
        end
      end

      def validate_each record, attribute, value
        record.errors.add attribute, :blank if value.blank?
      end
    end
  end
end