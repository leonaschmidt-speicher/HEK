class Tutor < ActiveRecord::Base
#  establish_connection("hekdb_#{ENV['RAILS_ENV']}")
  establish_connection( 'hekdb_production' )
  self.table_name = 'tutorenliste'

  def self.anzahl
    all.map do |tutor|
      "#{tutor.vorname} #{tutor.zimmernummer}"
    end.uniq.count
  end
end
