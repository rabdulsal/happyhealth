class AddMedicalIdToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :medical_id, :integer
  end
end
