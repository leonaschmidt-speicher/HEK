class CreateKommentare < ActiveRecord::Migration
  def change
    create_table :kommentare do |t|
      t.text :text
      t.string :benutzer
      t.integer :bewerbung_id

      t.timestamps
    end
  end
end
