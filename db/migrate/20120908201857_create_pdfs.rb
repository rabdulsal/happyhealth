class CreatePdfs < ActiveRecord::Migration
  def change
    create_table :pdfs do |t|
      t.string :name
      t.integer :office_id

      t.timestamps
    end
  end
end
