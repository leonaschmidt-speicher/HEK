class Tutor < ActiveRecord::Base
  #choose depending on the running environment the correct db named in config/database.yml
  establish_connection "hekdb_#{Rails.env}"
  #select the table in the database
  self.table_name='tutorenliste'

  def self.anzahl
    all.map do |tutor|
      "#{tutor.vorname} #{tutor.zimmernummer}"
    end.uniq.count
  end
end
