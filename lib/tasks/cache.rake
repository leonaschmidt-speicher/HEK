namespace :cache do
  task :expire => :environment do
    ActionController::Base.new.expire_fragment 'startseite_bilder'
  end
end