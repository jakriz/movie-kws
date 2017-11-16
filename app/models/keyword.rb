class Keyword < ActiveRecord::Base

  has_and_belongs_to_many :movies, counter_cache: true

  def amounts_per_year(adjusted=true)
    col_name = adjusted ? :gross_amount_adjusted : :gross_amount
    movies.where("#{col_name} IS NOT NULL").group(:year).order(:year).sum(col_name)
  end

  def movies_for_year(year, adjusted=true)
    col_name = adjusted ? :gross_amount_adjusted : :gross_amount
    movies.where("year = ? AND #{col_name} IS NOT NULL", year).order(:rank_for_year)
  end

  def self.autocomplete(term, limit=10)
    where("word LIKE ?", "#{term}%").order('movies_count DESC').limit(limit).pluck(:word)
  end

  def self.update_movies_count_cache
    all.each do |keyword|
      keyword.update_attribute(:movies_count, keyword.movies.count)
    end
  end

end
