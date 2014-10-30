module Moveflat
  class Place
    attr_accessor :available_from, :date_listed, :description, :image_url, :interests, 
                  :features, :link, :location, :moveflat_id, :occupations, :place_type, 
                  :price_per_month, :short_let, :title

    def initialize(params)
      @available_from = params.fetch(:available_from)
      @date_listed = params.fetch(:date_listed)
      @description = params.fetch(:description)
      @image_url = params.fetch(:image_url)
      @includes_council_tax = params.fetch(:includes_council_tax)
      @includes_utilities = params.fetch(:includes_utilities)
      @link = params.fetch(:link)
      @title = params.fetch(:title)
      @location = params.fetch(:location)
      @moveflat_id = params.fetch(:moveflat_id)
      @price_per_month = params.fetch(:price_per_month)
      @place_type = params.fetch(:place_type)
      @short_let = params.fetch(:short_let)
    end

    def includes_utilities?
      @includes_utilities
    end

    def includes_council_tax?
      @includes_council_tax
    end

    # def available_from
    #   if @available_from <= Date.today
    #     "Now"
    #   else
    #     @available_from
    #   end
    # end
  end
end
