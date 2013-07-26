class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.date :age_onset
      t.string :status
      t.string :condition

      t.timestamps
    end
  end
end
