class Tutor < ActiveRecord::Base
  establish_connection :hekdb
  set_table_name 'tutorenliste'

  def self.anzahl
    all.map do |tutor|
      "#{tutor.vorname} #{tutor.zimmernummer}"
    end.uniq.count
  end
end