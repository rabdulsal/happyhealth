class AddFormIdToInsurance < ActiveRecord::Migration
  def change
    add_column :insurances, :form_id, :integer
  end
end
