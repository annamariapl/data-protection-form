class AddUntertitelToChapter < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :unter_titel, :text
  end
end
