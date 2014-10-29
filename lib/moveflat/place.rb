module Moveflat
  class Place
    attr_accessor :available_from, :date_listed, :description, :image_url, :link, 
                  :title, :locations, :place_type, :price

    def initialize(params)
      @available_from = params.fetch(:available_from)
      @date_listed = params.fetch(:date_listed)
      @description = params.fetch(:description)
      @image_url = params.fetch(:image_url)
      @link = params.fetch(:link)
      @title = params.fetch(:title)
      @locations = params.fetch(:locations)
      @price = params.fetch(:price)
      @place_type = params.fetch(:place_type)
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
