class RenameEventDateToDate < ActiveRecord::Migration[6.1]
  def change
    rename_column(:tickets, :event_date, :date)
  end
end
