class AddNoteToMoods < ActiveRecord::Migration[6.0]
  def change
    add_column :moods, :note, :text
  end
end
