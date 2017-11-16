module Downloader
  class Utils
    def self.parse_link(link)
      link.match(/tt(\d+)/)[1].to_i
    end

    def self.gross_string_to_amount(s)
      return nil if s.nil? || s == '-'

      s.gsub(/,/,'').to_d
    end
  end
end
