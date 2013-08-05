class ChangeAgeOffsetForProblem < ActiveRecord::Migration
  def up
   	remove_column :problems, :age_onset
    add_column :problems, :age_onset, :integer
  end

  def down
    remove_column :problems, :age_onset
    add_column :problems, :age_onset, :date
  end
end
