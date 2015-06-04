require 'open-uri'

module Downloader
  class KeywordsParser

    def initialize(movie)
      @movie = movie
    end

    def download_and_save!
      doc = Nokogiri::HTML(open(url))
      doc.css('div#keywords_content table .sodatext a').each do |kw_link|
        word = kw_link.content
        keyword = Keyword.find_or_create_by(word: word)

        @movie.keywords << keyword
      end
    end

    private

    def url
      "http://www.imdb.com/title/tt#{@movie.imdb_id}/keywords"
    end

  end
end
