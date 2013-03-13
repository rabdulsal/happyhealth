class ChangeDataTypeforMedicationType < ActiveRecord::Migration
  def up
    remove_column :medications, :type
  end

  def down
    add_column :medications, :type
  end
end
