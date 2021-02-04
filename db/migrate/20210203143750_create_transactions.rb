class CreateTransactions < ActiveRecord::Migration[6.0]
  def up
    create_table :transactions do |t|
      t.string :uuid, null: false
      t.decimal :amount
      t.string :status, null: false
      t.string :customer_email
      t.string :customer_phone
      t.string :notification_url
      t.references :parent_transaction, foreign_key: { to_table: :transactions }
      t.references :merchant, foreign_key: { to_table: :users }

      t.index :uuid, unique: true

      t.timestamps
    end
  end

  def down
    drop_table :transactions
  end
end
