class AddChapterReferenceToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :chapter, foreign_key: true
  end
end
