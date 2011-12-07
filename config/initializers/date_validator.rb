module ActiveModel
  module Validations
    class DateValidator
      def validate_each_with_presence record, attr_name, value
        unless value.nil?
          if value.is_a? String
            value = DateTime.strptime(value, '%Y-%m-%d').to_time.in_time_zone rescue nil
          end
          if value.nil?
            record.errors.add attr_name, :not_a_date, options
          else
            validate_each_without_presence record, attr_name, value
          end
        end
      end

      alias_method_chain :validate_each, :presence
    end
  end
end