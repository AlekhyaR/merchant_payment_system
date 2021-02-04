class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :description
      t.integer :role, default: 0
      t.integer :status, default: 0

      t.index :email, unique: true

      t.timestamps
    end
  end
end