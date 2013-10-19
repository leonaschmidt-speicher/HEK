class Bewohner < ActiveRecord::Base
  #select the correct db depending on the running environment
  establish_connection("hekdb_#{Rails.env}")
  #select the right table in the chosen db
  self.table_name = 'bewohnerliste_intern'
end