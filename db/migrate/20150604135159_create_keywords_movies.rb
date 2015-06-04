class CreateKeywordsMovies < ActiveRecord::Migration
  def change
    create_table :keywords_movies do |t|
      t.references :keyword, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
    end
  end
end
