module InfoExtractors
  def extract_moveflat_id(place_html)
    place_html["id"].match(/[0-9]+/).to_s
  end

  def extract_link(place_html)
    Moveflat::BASE_URL + place_html.css('a').first["href"]
  end

  def extract_title(place_html)
    title = remove_bad_html(place_html.css('a').last.text)

    # Only replace the first instance of the word, since we want to remove the
    # unnecessary 'London' that prefixes EVERY title, but don't want to remove
    # 'London' from titles that need it e.g. London Bridge
    title.sub(/london/i, "").strip
  end

  def extract_location(place_title)
    Moveflat::LONDON_AREAS.each do |area|
      return area if place_title.downcase.match(area.downcase)
    end

    return "Unknown"
  end

  # Image URL take the form: 
  # http://www.moveflat.com/_ImageServer.aspx?f={MOVEFLAT_ID}{SEQUENCE}.jpg
  # e.g. first image http://www.moveflat.com/_ImageServer.aspx?f=459997A.jpg
  # e.g. second image http://www.moveflat.com/_ImageServer.aspx?f=459997B.jpg
  # ...and so on. Note that the sequence is alphabetical not numerical
  # Also, if a flat has 4 images uploaded, the sequence identifier 'F' will actually
  # still return an image, but it will be a default image that Moveflat uses
  def build_image_url(moveflat_id)
    "#{Moveflat::BASE_IMAGE_URL}f=#{moveflat_id}A.jpg"
  end

  def extract_place_type(place_title)
    if place_title.match(/flatshare/i)
      :flat_share
    elsif place_title.match(/flat/i)
      :whole_flat
    elsif place_title.match(/houseshare|house share/i)
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

  def extract_price_per_month(place_title)
    place_title.match(/£[0-9]+/).to_s.delete("£").to_f
  end

  def extract_date_listed(place_text)
    date_string = place_text.match(/On or renewed [0-9]{1,2} (January|February|March|April|May|June|July|August|September|October|November|December)/i).to_s
    Date.parse(date_string.delete("On or renewed "))
  end

  # TODO: DRY this up with other date extraction method
  def extract_availability(place_text)
    if place_text.match(/Avail Now/i)
      Date.today
    else
      date_string = place_text.match(/Avail[ a-zA-Z]* [0-9]{1,2} (January|February|March|April|May|June|July|August|September|October|November|December)/i).to_s
      Date.parse(date_string)
    end
  end

  # Removes tabs/whitespace/returns/newlines
  def remove_bad_html(html)
    html.gsub(/\t|\r|\n/, " ").gsub(/\s{2,}/, " ").strip
  end

  def extract_short_let(place_html)
    if place_html.match(/Short Let/i)
      true
    else
      false
    end
  end

  def extract_bill_info(place_text)
    {
      includes_council_tax: !place_text.match(/\+CTax/i),
      includes_utilities: !place_text.match(/\+Util/i)
    }
  end

  def extract_interests(place_html)
    remove_bad_html(place_html.css('span').first.next.text.strip)
  end

  def extract_occupations(place_html)
    remove_bad_html(place_html.css('span').last.next.text.strip)
  end

  def extract_features(place_html)
    place_html.css('input[type=checkbox]').map do |feature|
      remove_bad_html(feature.next.text).delete(".")
    end
  end

  def extract_single_page_description(place_html)
    start_node = place_html.at_xpath("//h3[text()='\r\n\t\tFlatshare \r\n\t\t\r\n\t\t Description']")
    end_node = place_html.at_xpath("//h3[text()='Flatshare interests and occupations']")

    current_paragraph = start_node
    description = ""

    until (current_paragraph = current_paragraph.next) == end_node do
      description << current_paragraph.text
    end

    remove_bad_html(description)
  end

  def build_image_list(moveflat_id)
    alpha_index = 0
    images = []

    until (image = open("http://www.moveflat.com/_ImageServer.aspx?f=#{moveflat_id}#{('A'..'Z').to_a[alpha_index]}-+.jpg")).class == StringIO
      puts image.class, " ", alpha_index
      images << image
      alpha_index += 1
      sleep 2
    end
  end

  def extract_image_count(place_html)
    place_html.xpath("//a[@style='margin:1px;']/img").size
  end

  def extract_moveflat_id_from_single_page(place_html)
    place_html.at_css("#_mp")["attr"]
  end
end
