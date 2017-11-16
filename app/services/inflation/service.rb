require 'open-uri'

module Inflation
  class Service

    def calculate_price_now(year: year, amount: amount)
      open(build_url(year, amount)).read.tr('""', '').to_d
    end

    private

    def build_url(from, amount)
      now = Date.current.year
      "https://www.statbureau.org/calculate-inflation-price-json?country=united-states&start=#{from}%2F1%2F1&end=#{now}%2F12%2F1&amount=#{amount}&format=false"
    end

  end
end
