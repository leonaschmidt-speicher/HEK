require 'active_model/validations'
require 'active_support/i18n'

module ActiveModel
  module Validations
    class DateTimeValidator < EachValidator
      CHECKS = { :after => :>, :after_or_equal_to => :>=, :before => :<, :before_or_equal_to => :<= }.freeze

      def initialize options
        super options.reverse_merge(:allow_blank => false)
      end

      def setup klass
        klass.class_eval { @date_formats ||= Hash.new }
        @attributes.each do |attribute|
          format = options[:format]
          unless format.nil?
            klass.class_eval do
              @date_formats[attribute.to_sym] = format

              # rails / activerecord / lib / active_record / attribute_methods / time_zone_conversion.rb
              define_method "#{attribute}=" do |original_time|
                time = original_time
                unless time.acts_like? :time
                  time = time.is_a?(String) ? DateTime.strptime(time, format).to_time : value.to_time rescue time
                end
                time = time.in_time_zone rescue nil if time
                write_attribute attribute, original_time
                @attributes_cache[attribute.to_s] = time
                send "#{attribute}_will_change!" unless instance_variable_get("@#{attribute}") == time
                instance_variable_set "@#{attribute}", time
              end

              # Damit Daten nach abschicken eines gültigen Formulars sauber angezeigt werden ...
              define_method "#{attribute}_before_type_cast" do
                I18n.localize send(attribute), :format => format rescue super()
              end
            end
          end
        end
      end

      def check_validity!
        options.slice(*CHECKS.keys).each do |option, value|
          next if is_time?(value) || value.is_a?(Proc) || value.is_a?(Symbol) || (defined?(ActiveSupport::TimeWithZone) and value.is_a? ActiveSupport::TimeWithZone)
          raise ArgumentError, ":#{option} must be a time, a date, a time_with_zone, a symbol or a proc"
        end
      end

      def validate_each record, attribute, value
        raw_value = record.send "#{attribute}_before_type_cast"
        return if options[:allow_blank] and raw_value.blank?
        validate_format_of record, attribute, raw_value
        validate_range_of record, attribute, value unless value.nil?
      end

      def validate_format_of record, attribute, raw_value
        format = record.date_format_for attribute
        DateTime.strptime raw_value, format unless format.nil?
      rescue
        record.errors.add attribute, :not_a_date
      end

      def validate_range_of record, attribute, value
        options.slice(*CHECKS.keys).each do |option, option_value|
          option_value = option_value.call(record) if option_value.is_a? Proc
          option_value = record.send(option_value) if option_value.is_a? Symbol

          original_value = value
          original_option_value = option_value

          if defined? ActiveSupport::TimeWithZone
            option_value = option_value.to_datetime if option_value.is_a? ActiveSupport::TimeWithZone
            value = value.to_datetime if value.is_a? ActiveSupport::TimeWithZone
          end

          if defined? Date
            option_value = option_value.to_datetime if option_value.is_a? Date
            value = value.to_datetime if value.is_a? Date
          end

          unless is_time?(option_value) and value.to_i.send(CHECKS[option], option_value.to_i)
            record.errors.add attribute, option, options.merge(
              :value => original_value,
              :date  => (I18n.localize(original_option_value, :format => format) rescue original_option_value)
            )
          end
        end
      end

    private
      def is_time? object
        object.is_a?(Time) || (defined?(Date) and object.is_a?(Date)) || (defined?(ActiveSupport::TimeWithZone) and object.is_a?(ActiveSupport::TimeWithZone))
      end
    end

    class DateValidator < DateTimeValidator
    end

    class TimeValidator < DateTimeValidator
    end

    module HelperMethods
      def validates_date_of *attributes
        validates_with DateValidator, _merge_attributes(attributes)
      end

      def validates_time_of *attributes
        validates_with TimeValidator, _merge_attributes(attributes)
      end

      def date_format_for attribute
        self.class.class_eval { @date_formats[attribute.to_sym] if defined? @date_formats }
      end

      def read_attribute_before_type_cast attribute
        value = super attribute
        Rails.logger.debug "#{attribute}: #{value}"
        if value.is_a? Time
          format = date_format_for attribute
          I18n.localize value, :format => format unless format.nil?
        else
          value
        end
      end
    end
  end
end