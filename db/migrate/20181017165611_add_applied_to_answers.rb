class AddAppliedToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :applied, :boolean
  end
end
