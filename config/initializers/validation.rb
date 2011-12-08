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

    class DateValidator < EachValidator
      def validate_each_with_format record, attribute, value
        raw_value = record.send "#{attribute}_before_type_cast"
        format = record.try :date_format_for, attribute
        unless format.nil? or raw_value.blank?
          begin
            DateTime.strptime raw_value, format
          rescue
            record.errors.add attribute, :not_a_date
          end
        end
        validate_each_without_format record, attribute, value unless value.nil?
      end

      alias_method_chain :validate_each, :format
    end
  end
end