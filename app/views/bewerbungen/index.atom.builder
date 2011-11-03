atom_feed :language => 'de-DE' do |feed|
  feed.title 'Bewerbungen'
  feed.updated @bewerbungen.first.updated_at unless @bewerbungen.empty?

  @bewerbungen.each do |bewerbung|
    feed.entry bewerbung do |entry|
      entry.url bewerbung_url(bewerbung)
      entry.title bewerbung.name
      entry.content "[#{bewerbung.geschlecht}] #{bewerbung.alter} Jahre ##{bewerbung.anzahl_abgeschlossener_fachsemester}. Semester :: #{l bewerbung.fruehestens unless bewerbung.fruehestens.nil?} - #{l bewerbung.wunsch unless bewerbung.wunsch.nil?} - #{l bewerbung.spaetestens unless bewerbung.spaetestens.nil?}"
      entry.updated bewerbung.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")
    end
  end
end