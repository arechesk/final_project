class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.integer :ticket_id
      t.string :first_name
      t.string :last_name
      t.string :doc_type
      t.string :doc_number

      t.timestamps
    end
  end
end
