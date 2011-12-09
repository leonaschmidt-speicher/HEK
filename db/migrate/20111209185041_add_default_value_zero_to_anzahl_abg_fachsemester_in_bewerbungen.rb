class AddDefaultValueZeroToAnzahlAbgFachsemesterInBewerbungen < ActiveRecord::Migration
  def change
    change_column_default :bewerbungen, :anzahl_abgeschlossener_fachsemester, 0
  end
end