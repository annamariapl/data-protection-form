class CreateAgreementTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :agreement_templates do |t|
      t.string :title

      t.timestamps
    end
  end
end
