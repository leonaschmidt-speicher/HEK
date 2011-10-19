class RenameMittelungenToOrganisatorischeMitteilungen < ActiveRecord::Migration
  def change
    rename_column :bewerbungen, :mitteilungen, :organisatorische_mitteilungen
  end
end
