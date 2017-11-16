module Inflation
  class Calculator
    
    def update_all_movies!
      Movie.with_gross_amount.each do |movie|
        adjusted = Service.new.calculate_price_now(year: movie.year, amount: movie.gross_amount)
        movie.update_attribute(:gross_amount_adjusted, adjusted)
      end
      puts 'Movies updated'
    end

  end
end
