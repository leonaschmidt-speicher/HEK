class Kommentar < ActiveRecord::Base
  self.table_name = 'kommentare'

  belongs_to :bewerbung
end