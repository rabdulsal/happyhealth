class SecurityQuestionable < ActiveRecord::Migration
  def up
  	create_table :security_questions do |t|
	  	t.string :locale, :null => false
	  	t.string :name, :null => false
	end

	SecurityQuestion.create! locale: :en, name: "What is your Mother's maiden name?"
	SecurityQuestion.create! locale: :en, name: "In what city were you born?"
	SecurityQuestion.create! locale: :en, name: "What is the name of your first pet?"
	SecurityQuestion.create! locale: :en, name: "What is the name of your childhood best friend?" 
	
  end

  def down
  	drop_table :security_questions
  end
end
