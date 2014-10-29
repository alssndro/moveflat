require "moveflat/version"
require "moveflat/scraper"
require "moveflat/place"

require 'yaml'

module Moveflat
  BASE_URL = "http://moveflat.com"

  # Image URLs need www
  BASE_IMAGE_URL = "http://www.moveflat.com/_ImageServer.aspx?"

  LONDON_AREAS = YAML::load_file("london_areas.yml")
end
