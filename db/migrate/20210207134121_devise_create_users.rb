# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :name,               null: false
      t.string :email,              null: false
      t.string :encrypted_password, null: false
      t.string :description
      t.integer :role, default: 0
      t.integer :status, default: 0

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  end
end
