class RenameColumnInformationenToMotivationInBewerbungen < ActiveRecord::Migration
  def up
    rename_column :bewerbungen, :informationen, :motivation
  end

  def down
    rename_column :bewerbungen, :motivation, :informationen
  end
end