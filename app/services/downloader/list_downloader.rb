module Downloader
  class ListDownloader
    YEAR_RANGE = (1923..Date.current.year)
    TIMEOUT = 15.seconds

    def download_all
      ActiveRecord::Base.logger.level = 1

      YEAR_RANGE.each do |year|
        download_list_for(year)
        sleep(TIMEOUT)
      end
    end

    def download_list_for(year)
      puts "Downloading for year: #{year}"
      list_parser = ListParser.new(year)
      list_parser.download_and_save!
    end

  end
end
