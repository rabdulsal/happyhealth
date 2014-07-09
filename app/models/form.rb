class Form < ActiveRecord::Base
  include PublicActivity::Common
  attr_accessible :user_id,
                  :personal_attributes,
                  :dental_attributes,
                  :emergencies_attributes,
                  :insurance_attributes,
                  :responsible_attributes,
                  :medical_attributes,
                  :vision_attributes

  belongs_to :user
  has_one :personal, dependent: :destroy
  has_one :responsible, dependent: :destroy
  has_one :medical, dependent: :destroy
  has_many :emergencies, dependent: :destroy
  has_many :insurances, dependent: :destroy
  has_one :vision, dependent: :destroy
  has_one :dental, dependent: :destroy
  has_many :payers, through: :insurances, dependent: :destroy

  accepts_nested_attributes_for :personal,
                                :dental,
                                :emergencies,
                                :insurances,
                                :responsible,
                                :medical,
                                :vision

  delegate :first_name, :last_name, to: :personal, allow_nil: true

  def update_activity params
    p_status, p_changes = personal.update_attributes_changed(params[:form][:personal_attributes])
    p_status, e0_changes = emergencies[0].update_attributes_changed(params[:form][:emergencies_attributes]["0"])
    p_status, e1_changes = emergencies[1].update_attributes_changed(params[:form][:emergencies_attributes]["1"])
    p_status, i0_changes = insurances[0].update_attributes_changed(params[:form][:insurances_attributes]["0"])
    # p_status, i1_changes = insurances[1].update_attributes_changed(params[:form][:insurances_attributes]["1"])
    p_status, d_changes = dental.update_attributes_changed(params[:form][:dental_attributes])
    p_status, v_changes = vision.update_attributes_changed(params[:form][:vision_attributes]["1"])

    medical_changes = {}
    allergies_attributes = params[:form][:medical_attributes][:allergies_attributes]
    allergies_attributes.keys.each do |attr_id|
      p_status, a_changes = medical.allergies[attr_id.to_i].update_attributes_changed(allergies_attributes[attr_id])
      medical_changes.merge!(Hash[a_changes.map {|k, v| [k + attr_id, v] }])
    end

    medications_attributes = params[:form][:medical_attributes][:medications_attributes]
    medications_attributes.keys.each do |attr_id|
      p_status, m_changes = medical.medications[attr_id.to_i].update_attributes_changed(medications_attributes[attr_id])
      medical_changes.merge!(Hash[m_changes.map {|k, v| [k + attr_id, v] }])
    end

    problems_attributes = params[:form][:medical_attributes][:problems_attributes]
    problems_attributes.keys.each do |attr_id|
      p_status, pr_changes = medical.problems[attr_id.to_i].update_attributes_changed(problems_attributes[attr_id])
      medical_changes.merge!(Hash[pr_changes.map {|k, v| [k + attr_id, v] }])
    end

    changes = {"Personal" => p_changes,
               "Emergency Contact 1" => e0_changes,
               "Emergency Contact 2" => e1_changes,
               "Primary Insurance" => i0_changes,
               # "Secondary Insurance" => i1_changes,
               "Dental Insurance" => d_changes,
               "Vision Insurance" => v_changes,
               "Medical" => medical_changes,
              }

    changes.keys.each do |key|
      changes[key].keys.each do |attr|
        if changes[key][attr] == [nil,nil] then changes[key].delete(attr) end
      end
    end

    changes = changes.delete_blank

    create_activity :update, parameters: changes, owner: user if changes != {}
  end

end

class Hash
  def delete_blank
    delete_if{|k, v| v.empty? or v.instance_of?(Hash) && v.delete_blank.empty?}
  end
end
