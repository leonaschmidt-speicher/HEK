class Bewerbung < ActiveRecord::Base
  PERSOENLICHE_ANGABEN = %w[vorname nachname geburtsdatum staatsangehoerigkeit geschlecht familienstand religion foto lebenslauf]
  ANSCHRIFT_DER_ELTERN = %w[strasse_und_nummer plz ort land]
  WEITERE_KONTAKTINFORMATIONEN = %w[email, mobiltelefon, festnetztelefon]
  set_table_name "bewerbungen"

  # set up paperclip
  has_attached_file :foto, {
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :url => "/uploads/:hash.:extension",
    :hash_secret => "712be566717dae4560fd7cfcf8214369"
  }
  validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates_attachment_size :foto, :less_than => 4.megabytes

  has_attached_file :lebenslauf, {
    :url => "/uploads/:hash.:extension",
    :hash_secret => "6a3d3eebbf7356f1420e4359d3r"
  }
  validates_attachment_content_type :lebenslauf, :content_type => ['application/postscript',
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
        
  validates :plz,
            :firma_plz,
            :geplante_wohndauer,
        :numericality => true
        
end
