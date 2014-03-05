# encoding: utf-8
class Bewerbung < ActiveRecord::Base
  PERSOENLICHE_ANGABEN = %w[vorname nachname geburtsdatum staatsangehoerigkeit geschlecht familienstand religion temp_foto foto temp_foto_content_type foto_content_type temp_foto_file_size foto_file_size temp_lebenslauf lebenslauf temp_lebenslauf_content_type lebenslauf_content_type temp_lebenslauf_file_size lebenslauf_file_size]
  ANSCHRIFT_DER_ELTERN = %w[strasse_und_nummer plz ort land]
  WEITERE_KONTAKTINFORMATIONEN = %w[email mobiltelefon festnetztelefon]
  ANGABEN_ZUM_STUDIUM = %w[hochschule hauptfach anzahl_abgeschlossener_fachsemester studienende angestrebter_abschluss firma firma_plz firma_ort waehrend_der_praxisphasen_im_hek]
  ANGABEN_ZUM_EINZUG = %w[fruehestens wunsch spaetestens geplante_wohndauer]
  VORSTELLUNG = %w[komme_vorbei_am sprechstunde_im_monat vorstellungsgespraech_nicht_moeglich]
  ORGANISATORISCHE_MITTEILUNGEN = %w[organisatorische_mitteilungen]
  MOTIVATION = %w[motivation]

  self.table_name = 'bewerbungen'

  scope :nicht_zugesagt, where(:zugesagt => [false, nil])
  scope :nicht_abgesagt, where(:bestaetigt => true).where(:zugesagt => [true, nil])
  scope :bestaetigt, where(:bestaetigt => true)
  scope :aktuell, lambda { where('spaetestens > :today or (spaetestens is null and wunsch > :today)', :today => Time.zone.today) }

  has_many :bewertungen, :dependent => :destroy do
    def for benutzer
      @bewertung_for_benutzer ||= inject({}) { |hash, bewertung| hash[bewertung.benutzer] = bewertung.wert; hash }
      @bewertung_for_benutzer[benutzer]
    end
  end

  has_many :kommentare, :dependent => :destroy

  has_attached_file :temp_foto, {
    :styles => { :medium => "140x140>", :thumb => "100x100#" },
    :url => "/uploads/:hash.:extension",
    :hash_secret => "712be566717dae4560fd7cfcf8214369",
    :hash_data => ":class/:attachment/:style",
    :use_timestamp => false
  }
  has_attached_file :foto, {
    :styles => { :medium => "140x140>", :thumb => "48x48#" },
    :url => "/uploads/secure/:hash.:extension",
    :hash_secret => "712be566717dae4560fd7cfcf8214369",
    :hash_data => ":class/:attachment/:id/:style",
    :default_url => '/images/missing_:style.png',
    :use_timestamp => false
  }
  has_attached_file :temp_lebenslauf, {
    :url => "/uploads/:hash.:extension",
    :hash_secret => "6a3d3eebbf7356f1420e4359d3r",
    :hash_data => ":class/:attachment/:style",
    :use_timestamp => false
  }
  has_attached_file :lebenslauf, {
    :url => "/uploads/secure/:hash.:extension",
    :hash_secret => "6a3d3eebbf7356f1420e4359d3r",
    :hash_data => ":class/:attachment/:id/:style",
    :use_timestamp => false
  }
  validates_attachment_content_type :temp_foto, :content_type => ['image/jpeg', 'image/png', 'image/gif'], :message => 'Foto ist nicht vom Typ JPEG, PNG oder GIF'
  validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png', 'image/gif'], :message => 'Foto ist nicht vom Typ JPEG, PNG oder GIF'
  validates_attachment_size :temp_foto, :less_than => 4.megabytes, :message => 'Foto ist größer als 4 Megabyte'
  validates_attachment_size :foto, :less_than => 4.megabytes, :message => 'Foto ist größer als 4 Megabyte'

  validates_attachment_content_type :temp_lebenslauf, :content_type => ['application/pdf', 'text/pdf', 'application/x-pdf', 'text/x-pdf', 'application/acrobat', 'applications/vnd.pdf', 'application/postscript', 'application/rtf', 'text/rtf', 'text/richtext', 'application/msword', 'application/vnd.oasis.opendocument.text'], :message => 'Lebenslauf ist nicht vom Typ PDF, PostScript, RTF, Doc oder ODT'
  validates_attachment_content_type :lebenslauf, :content_type => ['application/pdf', 'text/pdf', 'application/x-pdf', 'text/x-pdf', 'application/acrobat', 'applications/vnd.pdf', 'application/postscript', 'application/rtf', 'text/rtf', 'text/richtext', 'application/msword', 'application/vnd.oasis.opendocument.text'], :message => 'Lebenslauf ist nicht vom Typ PDF, PostScript, RTF, Doc oder ODT'
  validates_attachment_size :temp_lebenslauf, :less_than => 6.megabytes, :message => 'Lebenslauf ist größer als 6 Megabyte'
  validates_attachment_size :lebenslauf, :less_than => 6.megabytes, :message => 'Lebenslauf ist größer als 6 Megabyte'

  validates :vorname,
            :nachname,
            :presence => true
  validates :geburtsdatum, :presence => true, :date => { :format => '%Y-%m-%d', :before => Proc.new { Time.zone.today - 14.years } }
  validates :strasse_und_nummer, :presence => true
  validates :plz, :presence => true, :numericality => { :greater_than => 0, :less_or_equal_than => 99999, :only_integer => true }
  validates :ort,
            :land,
            :email,
            :presence => true
  validates :firma_plz, :allow_blank => true, :numericality => { :greater_than => 0, :less_or_equal_than => 99999, :only_integer => true }
  validates :anzahl_abgeschlossener_fachsemester, :allow_blank => true, :numericality => { :greater_or_equal_than => 0, :only_integer => true }
  validates :geplante_wohndauer, :allow_blank => true, :numericality => { :greater_than => 0, :only_integer => true }
  validates :studienende, :allow_blank => true, :date => { :format => '%Y-%m', :after_or_equal_to => Proc.new { Time.zone.today.at_beginning_of_month } }
  validates :fruehestens, :allow_blank => true, :date => { :format => '%Y-%m', :before_or_equal_to => :wunsch }
  validates :wunsch, :presence => true, :date => { :format => '%Y-%m', :after_or_equal_to => Proc.new { Time.zone.today.at_beginning_of_month } }
  validates :spaetestens, :allow_blank => true, :date => { :format => '%Y-%m', :after_or_equal_to => :wunsch }
  validates :komme_vorbei_am, :allow_blank => true, :date => { :format => '%Y-%m-%d', :after_or_equal_to => Proc.new { Time.zone.today } }
  validates :sprechstunde_im_monat, :allow_blank => true, :date => { :format => '%Y-%m', :after_or_equal_to => Proc.new { Time.zone.today.at_beginning_of_month } }
  validates :vorstellungsgespraech_nicht_moeglich, :allow_blank => true, :time => { :format => '%H:%M' }
  validates :motivation, :presence => true

  after_initialize do
    anzahl_abgeschlossener_fachsemester ||= 0
  end

  def name
    "#{vorname} #{nachname}"
  end

  def alter
    ((Date.today.to_time - geburtsdatum.to_time) / 1.year).round
  end

  def telefon?
    festnetztelefon? or mobiltelefon?
  end

  def abgesagt?
    zugesagt == false
  end

  def update_bewertung
    transaction do
      bewertung = bewertungen.empty? ? 0 : (bewertungen.sum(:wert) / bewertungen.count.to_f)
      update_attribute :bewertung, bewertung
    end
  end

  def recover attribute, path
    if not send(attribute).file? and not path.blank?
      File.open "#{Rails.root}/public/uploads/#{sanitize_filename(path.first)}" do |file|
        send "#{attribute}=", file
      end
    end
  end

private
  # Wundert mich, dass du sowas brauchst.
  def sanitize_filename filename
    filename.strip.tap do |name|
      # NOTE: File.basename doesn't work right with Windows paths on Unix
      # get only the filename, not the whole path
      name.sub! /\A.*(\\|\/)/, ''
      # Finally, replace all non alphanumeric, underscore
      # or periods with underscore
      name.gsub! /[^\w\.\-]/, '_'
    end
  end
end