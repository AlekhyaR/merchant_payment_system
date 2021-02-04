class CreateMerchants < ActiveRecord::Migration[6.0]
  def change
    create_table :merchants do |t|
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
