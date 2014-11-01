require 'nokogiri'
require 'moveflat/info_extractors'
require 'moveflat/place'

# Parses the HTML of a list of places
# e.g http://www.moveflat.com/london-flat/flatshare-flatmate/property/Box/

module Moveflat
  class PlaceListParser
    include InfoExtractors

    attr_reader :html

    def initialize(html)
      @html = Nokogiri::HTML(html) do |config|
        config.strict.nonet
      end
    end

    def parse
      html.css('#sda td').map do |place_html|

        place_title = extract_title(place_html)
        bill_info = extract_bill_info(place_html.text)
        moveflat_id = extract_moveflat_id(place_html)

        flat_params = {
          available_from: extract_availability(place_html.text),
          date_listed: extract_date_listed(place_html.text),
          description: extract_description(place_html),
          image_url: build_image_url(moveflat_id),
          includes_council_tax: bill_info[:includes_council_tax],
          includes_utilities: bill_info[:includes_utilities],
          link: extract_link(place_html),
          location: extract_location(place_title),
          moveflat_id: moveflat_id,
          postcode: extract_postcode(place_title),
          place_type: extract_place_type(place_title),
          price_per_month: extract_price_per_month(place_title),
          short_let: extract_short_let(place_html.text),
          title: place_title
        }

        Place.new(flat_params)
      end
    end

  end
end
