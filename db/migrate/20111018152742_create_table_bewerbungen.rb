class CreateTableBewerbungen < ActiveRecord::Migration
  def up
    create_table :bewerbungen do |t|
      t.string :vorname
      t.string :nachname
      t.date :geburtsdatum
      t.string :staatsangehoerigkeit
      t.string :familienstand
      t.string :religion
      t.string :strasse_und_nummer
      t.integer :plz
      t.string :ort
      t.string :land
      t.string :email
      t.string :mobiltelefon
      t.string :festnetztelefon
      t.string :hochschule
      t.string :hauptfach
      t.integer :anzahl_abgeschlossener_fachsemester
      t.date :studienende
      t.string :angestrebter_abschluss
      t.string :firma
      t.integer :firma_plz
      t.string :firma_ort
      t.boolean :waehrend_der_praxisphasen_im_hek
      t.date :fruehestens
      t.date :wunsch
      t.date :spaetestens
      t.integer :geplante_wohndauer
      t.date :komme_vorbei_am
      t.date :sprechstunde_im_monat
      t.time :vorstellungsgespraech_nicht_moeglich
      t.text :mitteilungen
      t.text :informationen

      t.string   :foto_file_name
      t.string   :foto_content_type
      t.integer  :foto_file_size

      t.string   :lebenslauf_file_name
      t.string   :lebenslauf_content_type
      t.integer  :lebenslauf_file_size

      t.timestamps
    end
  end

  def down
    drop_table :bewerbungen
  end
end
