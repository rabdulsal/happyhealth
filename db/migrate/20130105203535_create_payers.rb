class CreatePayers < ActiveRecord::Migration
  def change
    create_table :payers do |t|
      t.string :payer_name
      t.string :payer_code
      
      t.timestamps
    end
  end
end
