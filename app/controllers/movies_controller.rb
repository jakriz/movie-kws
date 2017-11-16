class MoviesController < ApplicationController

  def index
    @movie_count = Movie.count
    @movie_gross = Movie.sum(:gross_amount_adjusted)
  end
end