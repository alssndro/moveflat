require 'open-uri'

module Moveflat
  class Scraper
    def scrape_list(url)
      raise InvalidUrl unless valid_url?(url)

      PlaceListParser.new(open(URI.parse(url))).parse
    end

    private

    def valid_url?(url)
      url.match(/^(https?:\/\/)?(www\.)?moveflat\.com/) ? true : false
    end
  end
end
