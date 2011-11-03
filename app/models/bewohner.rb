class Bewohner < ActiveRecord::Base
  establish_connection :hekdb
  set_table_name 'bewohnerliste_intern'
end