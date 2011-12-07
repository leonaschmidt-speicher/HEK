# encoding: utf-8

# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural /^(bewerbung|bewertung)$/i, '\1en'
  inflect.singular /^(bewerbung|bewertung)en/i, '\1'
#  inflect.irregular 'person', 'people'
#  inflect.uncountable %w( fish sheep )
end

class String
  def titleize_with_umlauts
    titleize_without_umlauts.gsub /ae|oe|ue/ do |match|
      case match
        when /ae/ then 'ä'
        when /oe/ then 'ö'
        when /ue/ then 'ü'
      end
    end
  end

  alias_method_chain :titleize, :umlauts
end