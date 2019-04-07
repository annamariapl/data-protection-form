class AddEditedAnswerToQuestions < ActiveRecord::Migration[5.2]
	def change
		add_column :questions, :edited_answer, :string
	end
end
