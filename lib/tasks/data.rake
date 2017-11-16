namespace :data do

  desc "Downloads all necessary data"
  task download: :environment do
    Downloader::ListDownloader.new.download_all!
    Inflation::Calculator.new.update_all_movies!
  end
end
