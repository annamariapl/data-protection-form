class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :agreement_template, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
