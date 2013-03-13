class TheResources < ActiveRecord::Migration
  def up
  	change_table :users do |t|
  		t.datetime :password_changed_at
  		t.string :unique_session_id, :limit => 20
      t.datetime :last_activity_at
      t.datetime :expired_at
      t.integer :security_question_id
      t.string :security_question_answer
  	end
    add_index :users, :password_changed_at
  	add_index :users, :last_activity_at
    add_index :users, :expired_at
  end

  def down
    change_table :users do |t|
      t.remove :password_changed_at
      t.remove :unique_session_id
      t.remove :last_activity_at
      t.remove :expired_at
      t.remove :security_question_id
      t.remove :security_question_answer
    end
    remove_index :users, :password_changed_at
    remove_index :users, :last_activity_at
    remove_index :users, :expired_at
  end
end
