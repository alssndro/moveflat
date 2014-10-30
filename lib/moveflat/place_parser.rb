require 'nokogiri'

# Parses the HTML of an individual place page
# e.g http://www.moveflat.com/c/123456789.htm

module Moveflat
  class PlaceParser
    include InfoExtractors

    attr_reader :html

    def initialize(html)
      @html = Nokogiri::HTML(html) do |config|
        config.strict.nonet
      end
    end

    def parse
      place_title = remove_bad_html(html.css("h1").first.text)
      bill_info = extract_bill_info(html.at_css("h3 + p").text)
      moveflat_id = extract_moveflat_id_from_single_page(@html)

      flat_params = {
        available_from: extract_availability(html.at_css("h3 + p").text),
        date_listed: extract_date_listed(html.at_css("h3 + p").text),
        description: extract_single_page_description(html),
        image_url: build_image_url(moveflat_id),
        includes_council_tax: bill_info[:includes_council_tax],
        includes_utilities: bill_info[:includes_utilities],
        link: "#{Moveflat::BASE_URL}/c/#{moveflat_id}.htm",
        location: extract_location(place_title),
        moveflat_id: moveflat_id,
        place_type: extract_place_type(place_title),
        price_per_month: extract_price_per_month(place_title),
        short_let: extract_short_let(html.text),
        title: place_title
      }

      Place.new(flat_params).tap do |place|
        place.interests = extract_interests(@html)
        place.occupations = extract_occupations(@html)
        place.features = extract_features(@html)
        place.images = build_image_list(@html)
      end
    end

    private

  end
end
