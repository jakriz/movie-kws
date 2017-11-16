class AddMoviesCountToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :movies_count, :integer, default: 0
    add_index :keywords, [:word, :movies_count]
  end
end
