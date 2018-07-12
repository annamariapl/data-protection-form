class CreateAgreementAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :agreement_answers do |t|
      t.references :answer, foreign_key: true
      t.references :agreement, foreign_key: true

      t.timestamps
    end
  end
end
