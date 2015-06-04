module Downloader
  class Utils
    def self.parse_link(link)
      link.match(/tt(\d+)/)[1].to_i
    end

    def self.gross_string_to_amount(s)
      return nil if s.nil? || s == '-'

      m_match = s.match(/\$(\d+|\d+\.\d+)M/)
      k_match = s.match(/\$(\d+|\d+\.\d+)K/)

      if !m_match.nil?
        m_match[1].to_d * 1000000
      elsif !k_match.nil?
        k_match[1].to_d * 1000
      else
        nil
      end
    end
  end
end
