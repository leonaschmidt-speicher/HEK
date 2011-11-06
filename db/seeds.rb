# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

bewerbungen = Bewerbung.create(
  vorname: 'Hermann',
  nachname: 'Ehlers',
  geburtsdatum: '1918-05-11',
  staatsangehoerigkeit: 'DE',
  religion: 'christlich evangelisch',
  strasse_und_nummer: 'Dunkelallee 1',
  plz: 76131,
  ort: 'Karlsruhe',
  land: 'DE',
  email: 'hermann@hek.uni-karlsruhe.de',
  hochschule: 'KIT',
  hauptfach: 'Physik',
  anzahl_abgeschlossener_fachsemester: 2,
  fruehestens: '2012-01-01',
  wunsch: '2012-02-01',
  spaetestens: '2013-01-01',
  geplante_wohndauer: 20,
  sprechstunde_im_monat: '2011-12',
  informationen: 'Nachdem ich nun schon einige Jahre im Bundestag aktiv war denke ich, es ist an der Zeit neue Wege zu beschreiten und neue Dinge kennen zu lernen.',
  bestaetigt: true
    )
