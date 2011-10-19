class AddGeschlechtToBewerbung < ActiveRecord::Migration
  def change
    add_column :bewerbungen, :geschlecht, :string
  end
end
