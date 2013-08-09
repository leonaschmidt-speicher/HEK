class Bewohner < ActiveRecord::Base
  establish_connection("hekdb_#{ENV['RAILS_ENV']}")
  set_table_name 'bewohnerliste_intern'
end