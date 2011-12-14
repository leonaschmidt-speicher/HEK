class Kommentar < ActiveRecord::Base
  set_table_name 'kommentare'

  belongs_to :bewerbung
end