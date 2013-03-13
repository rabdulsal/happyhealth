class DropFormsTable < ActiveRecord::Migration
  def up
    drop_table :forms
  end

  def down
    create_table :forms
  end
end
