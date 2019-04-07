class ChangeEditedAnswersInQuestion < ActiveRecord::Migration[5.2]
	def change
		rename_column :questions, :edited_answer, :default_answer
	end
end
