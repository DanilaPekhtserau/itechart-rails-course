class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :money_amount
      t.integer :note_id, null: true
      t.boolean :important, default: false
      t.integer :person_category_id
      t.timestamps
    end
  end
end
