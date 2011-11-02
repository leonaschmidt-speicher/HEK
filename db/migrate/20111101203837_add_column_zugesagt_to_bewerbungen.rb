class AddColumnZugesagtToBewerbungen < ActiveRecord::Migration
  def change
    add_column :bewerbungen, :zugesagt, :boolean
  end
end
