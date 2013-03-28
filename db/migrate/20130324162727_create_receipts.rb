class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.boolean :tos_priv
      t.integer :office_id
      t.integer :user_id

      t.timestamps
    end
  end
end
