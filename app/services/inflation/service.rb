module Inflation
  class Service
    include HTTParty

    base_uri 'https://www.statbureau.org'

    def rate_for_year(year)
      self.class.get('/calculate-inflation-rate-json', rate_options(year))
    end

    private

    def rate_options(year)
      {
        country: 'united-states',
        start: Date.new(year).to_s,
        end: Date.current.beginning_of_year.to_s
      }
    end
  end
end
