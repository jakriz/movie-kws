require 'open-uri'

module Downloader
  class KeywordsParser

    def download_and_save!(movie)
      doc = Nokogiri::HTML(open(url(movie.imdb_id)))
      doc.css('div#keywords_content table .sodatext a').each do |kw_link|
        word = kw_link.content
        keyword = Keyword.find_or_create_by(word: word)

        movie.keywords << keyword
      end
    end

    private

    def url(imdb_id)
      "http://www.imdb.com/title/tt#{imdb_id}/keywords"
    end

  end
end
