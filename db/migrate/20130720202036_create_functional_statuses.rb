class CreateFunctionalStatuses < ActiveRecord::Migration
  def change
    create_table :functional_statuses do |t|
      t.text :functional_condition
      t.date :effective_dates
      t.string :status

      t.timestamps
    end
  end
end
