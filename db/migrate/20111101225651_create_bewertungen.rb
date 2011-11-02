class CreateBewertungen < ActiveRecord::Migration
  def change
    create_table :bewertungen do |t|
      t.string :benutzer
      t.integer :wert
      t.integer :bewerbung_id

      t.timestamps
    end
    add_column :bewerbungen, :bewertung, :integer
  end
end