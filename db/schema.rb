# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111015094814) do

  create_table 'bewerbungen', :force => true do |t|
    t.string   'vorname'
    t.string   'nachname'
    t.date    'geburtsdatum'
    t.string   'staatsangehoerigkeit'
    t.string   'familienstand'
    t.string   'religion'
    t.string   'strasse_und_nummer'
    t.integer  'plz'
    t.string   'ort'
    t.string   'land'
    t.string   'e_mail'
    t.string   'mobiltelefon'
    t.string   'festnetztelefon'
    t.string   'hochschule'
    t.string   'hauptfach'
    t.string   'anzahl_abgeschlossener_fachsemester'
    t.string   'studienende'
    t.string   'angestrebter_abschluss'
    t.string   'firma'
    t.string   'firma_plz'
    t.string   'firma_ort'
    t.boolean  'waehrend_der_praxisphasen_im_hek'
    t.date     'fruehestens'
    t.date     'wunsch'
    t.date     'spaetestens'
    t.integer  'geplante_wohndauer'
    t.date     'komme_vorbei_am'
    t.date     'sprechstunde_im_monat'
    t.string   'vorstellungsgespraech_nicht_moeglich'
    t.text     'mitteilungen'
    t.text     'informationen'
    t.datetime 'created_at'
    t.datetime 'updated_at'

    t.string   'photo_file_name'
    t.string   'photo_content_type'
    t.integer  'photo_file_size'

    t.string   'cv_file_name'
    t.string   'cv_content_type'
    t.integer  'cv_file_size'
  end

  create_table 'sessions', :force => true do |t|
    t.string   'session_id', :null => false
    t.text     'data'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'sessions', ['session_id'], :name => 'index_sessions_on_session_id'
  add_index 'sessions', ['updated_at'], :name => 'index_sessions_on_updated_at'

end
