require 'open-uri'

module Downloader
  class ListParser
    BASE_URL = 'http://www.imdb.com/search/title?sort=boxoffice_gross_us&year='

    def initialize(year)
      @year = year
    end

    def download_and_save!
      doc = Nokogiri::HTML(open(url))
      doc.css('table.results tr.detailed').each_with_index do |block, index|
        movie = parse_movie(block, index)
        parse_genres(movie, block)
        parse_keywords(movie)
        puts "-- downloaded movie #{movie.title}"
      end
    end

    private

    def url
      "#{BASE_URL}#{@year},#{@year}"
    end

    def parse_movie(block, index)
      rank = index+1
      title = block.css('td.title a')[0].content
      imdb_id = Utils.parse_link(block.css('td.title a')[0]['href'])
      gross = Utils.gross_string_to_amount(block.css('td.sort_col')[0].content)

      Movie.create(title: title, imdb_id: imdb_id, year: @year, rank_for_year: rank, gross_amount: gross)
    end

    def parse_genres(movie, block)
      block.css('span.genre a').each do |genre_link|
        genre = Genre.find_or_create_by(name: genre_link.content)
        movie.genres << genre
      end
    end

    def parse_keywords(movie)
      KeywordsParser.new(movie).download_and_save!
    end

  end
end
