class AddLockableandTimeoutableToUsers < ActiveRecord::Migration
  def up
  	# Lockable
  	change_table :users do |t|
	    t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
	    t.string   :unlock_token # Only if unlock strategy is :email or :both
	    t.datetime :locked_at
	end
  add_index :users, :unlock_token, :unique => true
  end  

  def down
  	change_table :users do |t|
	  	t.remove :failed_attempts
	    t.remove :unlock_token
	    t.remove :locked_at
    end
  remove_index :users, :unlock_token
  end  
  
end
