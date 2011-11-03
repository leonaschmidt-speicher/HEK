class Tutor < ActiveRecord::Base
  establish_connection :hekdb
  set_table_name 'tutorenliste'
end