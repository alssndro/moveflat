require 'spec_helper'

RSpec.describe Moveflat::PlaceParser do
  let(:parser) { Moveflat::PlaceParser.new(File.read(File.dirname(__FILE__) + "/support/single_flat.html")) }

  describe "#parse" do
    let(:place) { parser.parse }

    it "returns a Place" do
      expect(place).to be_a(Moveflat::Place)
    end

    describe "the parsed Place" do
      it "has the correct title" do
        expect(place.title).to eq("Primrose Hill NW1, 4 Bed House share £950")
      end

      it "has the correct price per month" do
        expect(place.price_per_month).to eq(950)
      end

      it "has the correct link" do
        expect(place.link).to eq("http://moveflat.com/c/459997.htm")
      end

      it "has the correct image URL" do
        expect(place.image_url).to eq("http://www.moveflat.com/_ImageServer.aspx?f=459997A.jpg")
      end

      it "has the correct place type" do
        expect(place.place_type).to eq(:house_share)
      end

      it "has the correct description" do
        expect(place.description).to eq("Hello, We are looking for a new housemate in our beautiful large and airy house very well located in Primrose Hill. There is plenty of space in the house with 4 levels - one is a large modern kitchen and dining area, one has a spacious living area with 2 terraces on each side, the other 2 levels are with bedrooms and bathrooms. We are located along Regent's Canal where we have an outdoor dinging/bbq area. We also have a garage area which accommodates laundry, bicycles etc. The location is exceptional with Regent's Park, Primrose Hill shops& pubs, Camden market and Chalk Farm/Camden tube within a short walk. We are also 5 minutes walk from Morrison's supermarket, or Wholefoods in Camden. We are 3 professional women from France, Ireland and Australia. We're travelling very often but it is also a friendly and warm houseshare, we often share dinner and would like someone like-minded. Please drop us an email to arrange a viewing or for more information. Thanks!")
      end

      it "has the correct 'available' date" do
        expect(place.available_from).to eq(Date.new(2014,11,1))
      end        

      it "has the correct 'date listed' date" do
        expect(place.date_listed).to eq(Date.new(2014,10,26))
      end

      it "has the correct let short let type" do
        expect(place.short_let).to eq(false)
      end

      it "has the correct council tax included status" do
        expect(place.includes_council_tax?).to eq(true)
      end

      it "has the correct utilities included status" do
        expect(place.includes_utilities?).to eq(true)
      end

      it "has the correct location" do
        expect(place.location).to eq("Primrose Hill")
      end

      it "has the correct Moveflat ID" do
        expect(place.moveflat_id).to eq("459997")
      end      

      it "has the correct interests" do
        expect(place.interests).to eq("Socializing, Cooking, Shopping, Sports")
      end      

      it "has the correct occupations" do
        expect(place.occupations).to eq("Finance")
      end      

      it "has the correct features" do
        expect(place.features).to eq(["Living Room", "Double Bed", "Bike OK", "Broadband", "Central Heating", "Washing Machine", "Dishwasher", "Dryer", "Cleaner", "Garden/Roof terrace", "Car parking"])
      end

      it "has the correct list of images" do
        expect(place.images).to eq(["http://www.moveflat.com/_ImageServer.aspx?f=459997A.jpg",
                                    "http://www.moveflat.com/_ImageServer.aspx?f=459997B.jpg",
                                    "http://www.moveflat.com/_ImageServer.aspx?f=459997C.jpg",
                                    "http://www.moveflat.com/_ImageServer.aspx?f=459997D.jpg"])
      end 
    end
  end
end
