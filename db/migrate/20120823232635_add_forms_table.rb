class AddFormsTable < ActiveRecord::Migration
  def up
    create_table :forms do |t|
      t.integer :user_id
      
      t.timestamps
    end
  end

  def down
  end
end
