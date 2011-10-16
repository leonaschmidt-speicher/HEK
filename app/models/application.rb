class Application < ActiveRecord::Base
  has_attached_file :photo, {
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :url => "/uploads/:hash.:extension",
    :hash_secret => "712be566717dae4560fd7cfcf8214369"
  }
  has_attached_file :cv, {
    :url => "/uploads/:hash.:extension",
    :hash_secret => "6a3d3eebbf7356f1420e4359d3"
  }
end
