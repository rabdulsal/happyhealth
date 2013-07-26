class CreateSocialHistories < ActiveRecord::Migration
  def change
    create_table :social_histories do |t|
      t.text :description
      t.date :start_date
      t.string :end_date
      t.string :behavior

      t.timestamps
    end
  end
end
