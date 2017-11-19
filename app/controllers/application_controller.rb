class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :calculate_stats

  private

  def calculate_stats
    @movie_count = Movie.count
    @movie_gross = Movie.sum(:gross_amount_adjusted)
  end
end
