def textify bewerbung
  result = ""
  result += "[#{bewerbung.geschlecht}] " if bewerbung.geschlecht?
  result += "#{bewerbung.alter} Jahre "
  result += "##{bewerbung.anzahl_abgeschlossener_fachsemester}. Semester " if bewerbung.anzahl_abgeschlossener_fachsemester?
  result += ":: "
  unless bewerbung.fruehestens.blank? || bewerbung.fruehestens == bewerbung.wunsch
    result += "#{l bewerbung.fruehestens} < "
  end
  result += "#{l bewerbung.wunsch} "
  unless bewerbung.spaetestens.blank? || bewerbung.spaetestens == bewerbung.wunsch
    result += "< #{l bewerbung.spaetestens}"
  end
  result
end

atom_feed :language => 'de-DE' do |feed|
  feed.title 'Bewerbungen'
  feed.updated @bewerbungen.first.updated_at unless @bewerbungen.empty?

  @bewerbungen.each do |bewerbung|
    feed.entry bewerbung, :url => "http://www.hek.uni-karlsruhe.de/bewerbungen/#{bewerbung.id}" do |entry|
      entry.url "http://www.hek.uni-karlsruhe.de/bewerbungen/#{bewerbung.id}" #bewerbung_url(bewerbung)
      entry.title bewerbung.name
      entry.content textify(bewerbung)
      entry.updated bewerbung.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")
    end
  end
end