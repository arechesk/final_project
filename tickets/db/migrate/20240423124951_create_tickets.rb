class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :event_date
      t.string :category
      t.string :status

      t.timestamps
    end
  end
end
