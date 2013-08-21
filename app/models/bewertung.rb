class Bewertung < ActiveRecord::Base
  self.table_name = 'bewertungen'

  belongs_to :bewerbung
end