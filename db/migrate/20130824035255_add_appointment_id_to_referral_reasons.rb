class AddAppointmentIdToReferralReasons < ActiveRecord::Migration
  def change
    add_column :referral_reasons, :appointment_id, :integer
  end
end
