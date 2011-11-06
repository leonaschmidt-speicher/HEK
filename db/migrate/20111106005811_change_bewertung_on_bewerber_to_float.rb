class ChangeBewertungOnBewerberToFloat < ActiveRecord::Migration
  def change
    change_column :bewerbungen, :bewertung, :decimal, :precision => 5 
  end
end
