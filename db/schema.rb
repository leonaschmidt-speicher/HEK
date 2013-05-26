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

ActiveRecord::Schema.define(:version => 20111214125908) do

  create_table "bewerbungen", :force => true do |t|
    t.string   "vorname"
    t.string   "nachname"
    t.date     "geburtsdatum"
    t.string   "staatsangehoerigkeit"
    t.string   "familienstand"
    t.string   "religion"
    t.string   "strasse_und_nummer"
    t.integer  "plz"
    t.string   "ort"
    t.string   "land"
    t.string   "email"
    t.string   "mobiltelefon"
    t.string   "festnetztelefon"
    t.string   "hochschule"
    t.string   "hauptfach"
    t.integer  "anzahl_abgeschlossener_fachsemester",               :default => 0
    t.date     "studienende"
    t.string   "angestrebter_abschluss"
    t.string   "firma"
    t.integer  "firma_plz"
    t.string   "firma_ort"
    t.boolean  "waehrend_der_praxisphasen_im_hek"
    t.date     "fruehestens"
    t.date     "wunsch"
    t.date     "spaetestens"
    t.integer  "geplante_wohndauer"
    t.date     "komme_vorbei_am"
    t.date     "sprechstunde_im_monat"
    t.time     "vorstellungsgespraech_nicht_moeglich"
    t.text     "organisatorische_mitteilungen"
    t.text     "motivation"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.string   "lebenslauf_file_name"
    t.string   "lebenslauf_content_type"
    t.integer  "lebenslauf_file_size"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.string   "geschlecht"
    t.boolean  "bestaetigt",                                        :default => false
    t.string   "temp_foto_file_name"
    t.string   "temp_foto_content_type"
    t.string   "temp_lebenslauf_file_name"
    t.string   "temp_lebenslauf_content_type"
    t.integer  "temp_foto_file_size"
    t.integer  "temp_lebenslauf_file_size"
    t.boolean  "zugesagt"
    t.integer  "bewertung",                            :limit => 5, :default => 0
  end

  create_table "bewertungen", :force => true do |t|
    t.string   "benutzer"
    t.integer  "wert"
    t.integer  "bewerbung_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "kommentare", :force => true do |t|
    t.text     "text"
    t.string   "benutzer"
    t.integer  "bewerbung_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
