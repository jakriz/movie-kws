module Downloader
  class ListDownloader
    TIMEOUT = 15.seconds

    def download_all!
      ActiveRecord::Base.logger.level = 1
      @list_parser = ListParser.new

      Date.current.year.downto(1923) do |year|
        download_list_for!(year)
        sleep(TIMEOUT)
      end

      Keyword.update_movies_count
    end

    def download_list_for!(year)
      puts "Downloading for year: #{year}"
      @list_parser.download_and_save!(year)
    end

  end
end
