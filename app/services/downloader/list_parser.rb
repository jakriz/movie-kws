require 'open-uri'

module Downloader
  class ListParser

    def download_and_save!(year)
      doc = Nokogiri::HTML(open(url(year), 'X-Forwarded-For' => '165.225.145.83'))
      doc.css('.lister-item').each_with_index do |block, index|
        movie = parse_movie(year, block, index)
        parse_genres(movie, block)
        parse_keywords(movie)
        puts "-- downloaded movie #{movie.title}"
      end
    end

    private

    def url(year)
      "http://www.imdb.com/search/title?sort=boxoffice_gross_us&year=#{year}"
    end

    def parse_movie(year, block, index)
      rank = index+1
      header = block.css('h3.lister-item-header a')[0]
      title = header.content
      imdb_id = Utils.parse_link(header['href'])
      gross = parse_gross(block)

      Movie.create(title: title, imdb_id: imdb_id, year: year, rank_for_year: rank, gross_amount: gross)
    end

    def parse_genres(movie, block)
      block.css('span.genre a').each do |genre_link|
        genre = Genre.find_or_create_by(name: genre_link.content)
        movie.genres << genre
      end
    end

    def parse_gross(block)
      block.css("p.sort-num_votes-visible span").each_cons(2) do |v1, v2|
        return Utils.gross_string_to_amount(v2['data-value']) if (v1.content == 'Gross:')
      end
      nil
    end

    def parse_keywords(movie)
      KeywordsParser.new.download_and_save!(movie)
    end

  end
end
