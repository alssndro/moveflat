require 'moveflat/version'
require 'moveflat/scraper'

require 'yaml'

module Moveflat
  BASE_URL = "http://www.moveflat.com"

  BASE_IMAGE_URL = "http://www.moveflat.com/_ImageServer.aspx?"

  LONDON_AREAS = YAML::load_file("london_areas.yml")
end
