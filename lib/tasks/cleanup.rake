namespace :cleanup do
  task :unconfirmed => :environment do
    Bewerbung.nicht_bestaetigt.where("updated_at < :yesterday", :yesterday => Time.zone.today.yesterday).destroy_all
  end

  task :expired => :environment do
    Bewerbung.nicht_zugesagt.where("spaetestens < :one_month_ago or (spaetestens is null and wunsch < :one_month_ago)", :one_month_ago => Time.zone.today.prev_month).destroy_all
  end
end