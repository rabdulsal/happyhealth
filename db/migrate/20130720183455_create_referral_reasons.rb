class CreateReferralReasons < ActiveRecord::Migration
  def change
    create_table :referral_reasons do |t|
      t.text :visit_reason

      t.timestamps
    end
  end
end
