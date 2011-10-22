class AddBestaetigtToBewerbung < ActiveRecord::Migration
  def change
    add_column :bewerbungen, :bestaetigt, :boolean, :default => 0
  end
end
