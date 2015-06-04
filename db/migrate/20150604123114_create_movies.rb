class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :imdb_id, null: false
      t.string :title, null: false
      t.integer :year, null: false
      t.integer :rank_for_year, null: false
      t.decimal :gross_amount
      t.decimal :gross_amount_adjusted

      t.timestamps null: false
    end

    add_index :movies, :year
  end
end
