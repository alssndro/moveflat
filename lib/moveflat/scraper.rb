require 'nokogiri'
require 'json'
require 'open-uri'

#require_relative 'flat'

module Moveflat
  class Scraper
    def scrape_list(url)
      raise InvalidUrl unless valid_url?(url)

      doc = Nokogiri::HTML(open(URI.parse(url))) do |config|
        config.strict.nonet
      end

      doc.css('#sda td').map do |place_html|

        place_title = extract_title(place_html)

        flat_params = {
          available_from: extract_availability(place_html.text),
          date_listed: extract_date_listed(place_html.text),
          description: extract_description(place_html),
          image_url: extract_image_url(place_html),
          link: extract_link(place_html),
          locations: extract_locations(place_html),
          moveflat_id: extract_moveflat_id(place_html),
          place_type: extract_place_type(place_title),
          price: extract_price(place_title),
          title: place_title
        }

        Place.new(flat_params)
      end
    end

    private

    def valid_url?(url)
      url.match(/^(https?:\/\/)?(www\.)?moveflat\.com/) ? true : false
    end

    def extract_moveflat_id(place_html)
      place_html["id"].match(/[0-9]+/).to_s
    end

    def extract_link(place_html)
      Moveflat::BASE_URL + place_html.css('a').first["href"]
    end

    def extract_title(place_html)
      # Remove bad markup from string
      # e.g. extra tabs/newlines, double whitespace
      title = remove_bad_html(place_html.css('a').last.text)
      title.gsub(/london/i,"")
    end

    def extract_locations(place_html)
      []
    end

    def extract_image_url(place_html)
      Moveflat::BASE_IMAGE_URL +  place_html.at_css("img")["src"].match(/f=.+\.jpg/).to_s
    end

    def extract_place_type(place_title)
      if place_title.match(/flatshare/i)
        :flat_share
      elsif place_title.match(/flat/i)
        :whole_flat
      elsif place_title.match(/houseshare/i)
        :house_share
      elsif place_title.match(/house/i)
        :whole_house
      else
        :unknown
      end
    end

    def extract_description(place_html)
      remove_bad_html(place_html.at_css("p").text)
    end

    def extract_price(place_title)
      place_title.match(/£[0-9]+/).to_s
    end

    def extract_date_listed(place_text)
      date_string = place_text.match(/[0-9]{1,2} (January|February|March|April|May|June|July|August|September|October|November|December)/i).to_s
      Date.parse(date_string)
    end

    # TODO: DRY this up with other date extraction method
    def extract_availability(place_text)
      if place_text.match(/Avail Now/i)
        Date.today
      else
        date_string = place_text.match(/Avail [0-9]{1,2} (January|February|March|April|May|June|July|August|September|October|November|December)/i).to_s
        Date.parse(date_string)
      end
    end

    # Removes tabs/whitespace/returns/newlines
    def remove_bad_html(html)
      html.gsub(/\t|\r|\n/, "").gsub(/\s{2,}/, " ").strip
    end
  end
end


