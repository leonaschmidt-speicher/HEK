class MakeColumnBewertungOfBewerbungenDefaultToZero < ActiveRecord::Migration
  def up
    change_column :bewerbungen, :bewertung, :decimal, :precision => 5, :default => 0
  end

  def down
    change_column :bewerbungen, :bewertung, :decimal, :precision => 5
  end
end
