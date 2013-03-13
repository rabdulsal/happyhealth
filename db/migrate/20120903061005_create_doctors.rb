class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :title
      t.integer :office_id

      t.timestamps
    end
  end
end
