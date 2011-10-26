class Bewerbung < ActiveRecord::Base
  PERSOENLICHE_ANGABEN = %w[vorname nachname geburtsdatum staatsangehoerigkeit geschlecht familienstand religion foto lebenslauf]
  ANSCHRIFT_DER_ELTERN = %w[strasse_und_nummer plz ort land]
  WEITERE_KONTAKTINFORMATIONEN = %w[email, mobiltelefon, festnetztelefon]
  ANGABEN_ZUM_STUDIUM = %w[hochschule hauptfach anzahl_abgeschlossener_fachsemester studienende angestrebter_abschluss firma firma_plz firma_ort waehrend_der_praxisphasen_im_hek]
  ANGABEN_ZUM_EINZUG = %w[fruehestens wunsch spaetestens geplante_wohndauer]
  VORSTELLUNG = %w[komme_vorbei_am sprechstunge_im_monat vorstellungsgespraech_nicht_moeglich]
  ORGANISATORISCHE_MITTEILUNGEN = %w[organisatorische_mitteilungen]
  INFORMATIONEN = %w[informationen]
  set_table_name "bewerbungen"

  # set up paperclip
  has_attached_file :foto, {
    :styles => { :medium => "140x140>", :thumb => "100x100#" },
    :url => "/uploads/:hash.:extension",
    :hash_secret => "712be566717dae4560fd7cfcf8214369",
    :hash_data => ":class/:attachment/:id/:style"
  }
  validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates_attachment_size :foto, :less_than => 4.megabytes

  has_attached_file :lebenslauf, {
    :url => "/uploads/:hash.:extension",
    :hash_secret => "6a3d3eebbf7356f1420e4359d3r",
    :hash_data => ":class/:attachment/:id/:style"
  }
  validates_attachment_content_type :lebenslauf, :content_type => ['application/pdf',
                                                              'application/postscript',
                                                              'application/rtf',
                                                              'application/msword',
                                                              'application/vnd.oasis.opendocument.text']
  validates_attachment_size :lebenslauf, :less_than => 6.megabytes

  validates :vorname,
            :nachname,
            :geburtsdatum,
            :strasse_und_nummer,
            :plz,
            :ort,
            :land,
            :email,
            :wunsch,
            :informationen,
        :presence => true

  validates :plz, :numericality => {:greater_than => 0, :only_integer => true}
  validates :firma_plz, :numericality => { :greater_than => 0, :only_integer => true}, :allow_blank => true
  validates :anzahl_abgeschlossener_fachsemester, :numericality => { :greater_or_equal_than => 0, :only_integer => true}, :allow_blank => true
  validates :geplante_wohndauer, :numericality => { :greater_than => 0, :only_integer => true}, :allow_blank => true

end
