class Bewohner < ActiveRecord::Base
#  establish_connection("hekdb_#{ENV['RAILS_ENV']}")
  establish_connection("hekdb_#{Rails.env}")
#  establish_connection( 'hekdb_production' )
  self.table_name = 'bewohnerliste_intern'
end