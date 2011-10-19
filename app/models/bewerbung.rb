class Bewerbung < ActiveRecord::Base
  set_table_name "bewerbungen"

  # set up paperclip
  has_attached_file :foto, {
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :url => "/uploads/:hash.:extension",
    :hash_secret => "712be566717dae4560fd7cfcf8214369"
  }
  has_attached_file :lebenslauf, {
    :url => "/uploads/:hash.:extension",
    :hash_secret => "6a3d3eebbf7356f1420e4359d3r"
  }

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
end
