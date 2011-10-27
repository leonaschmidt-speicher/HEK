class AddTemporaryAttachments < ActiveRecord::Migration
  def change
    add_column :bewerbungen, :temp_foto_file_name, :string
    add_column :bewerbungen, :temp_foto_content_type, :string
    add_column :bewerbungen, :temp_lebenslauf_file_name, :string
    add_column :bewerbungen, :temp_lebenslauf_content_type, :string
    add_column :bewerbungen, :temp_foto_file_size, :integer
    add_column :bewerbungen, :temp_lebenslauf_file_size, :integer
  end
end
