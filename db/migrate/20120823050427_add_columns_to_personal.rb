class AddColumnsToPersonal < ActiveRecord::Migration
  def change
    add_column :personals, :first_name,                     :string
    add_column :personals, :last_name,                      :string
    add_column :personals, :middle_initial,                 :string
    add_column :personals, :date_of_birth,                  :string
    add_column :personals, :age,                            :integer
    add_column :personals, :ss_number,                      :string
    add_column :personals, :gender,                         :string
    add_column :personals, :address,                        :string
    add_column :personals, :city,                           :string
    add_column :personals, :state,                          :string
    add_column :personals, :zip_code,                       :integer
    add_column :personals, :home_phone,                     :string
    add_column :personals, :cell_phone,                     :string
    add_column :personals, :work_phone,                     :string
    add_column :personals, :email_address,                  :string
    add_column :personals, :marital_status,                 :string
    add_column :personals, :ethnicity,                      :string
    add_column :personals, :race,                           :string
    add_column :personals, :employer,                       :string
    add_column :personals, :employment_status,              :string
    add_column :personals, :occupation,                     :string
    add_column :personals, :work_address,                   :string
    add_column :personals, :number_of_dependents,           :integer
    add_column :personals, :employer_phone,                 :string
    add_column :personals, :employer_city,                  :string
    add_column :personals, :employer_state,                 :string
    add_column :personals, :employer_zipcode,               :string
    add_column :personals, :relationship_to_responsible_party,                   :string
    add_column :personals, :referred_by,                    :string
    add_column :personals, :form_id,                        :integer
  end
end
