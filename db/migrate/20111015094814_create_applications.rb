class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :vorname
      t.string :nachname
      t.string :geburtsdatum
      t.string :staatsangehoerigkeit
      t.string :familienstand
      t.string :religion
      t.string :foto
      t.string :foto_type
      t.string :lebenslauf
      t.string :lebenslauf_type
      t.string :strasse_und_nummer
      t.string :plz
      t.string :ort
      t.string :land
      t.string :e_mail
      t.string :mobiltelefon
      t.string :festnetztelefon
      t.string :hochschule
      t.string :hauptfach
      t.string :anzahl_abgeschlossener_fachsemester
      t.string :studienende
      t.string :angestrebter_abschluss
      t.string :firma
      t.string :firma_plz
      t.string :firma_ort
      t.string :waehrend_der_praxisphasen_im_hek
      t.string :fruehestens
      t.string :wunsch
      t.string :spaetestens
      t.string :geplante_wohndauer
      t.string :komme_vorbei_am
      t.string :sprechstunde_im_monat
      t.string :vorstellungsgespraech_nicht_moeglich
      t.string :mitteilungen
      t.string :informationen
      t.string :commenter
      t.text :body
      t.references :post

      t.timestamps
    end
  end
end
