class Bewertung < ActiveRecord::Base
  set_table_name 'bewertungen'

  belongs_to :bewerbung
end