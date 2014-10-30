require 'spec_helper'

RSpec.describe Moveflat::PlaceListParser do
  let(:parser) { Moveflat::PlaceListParser.new(File.read(File.dirname(__FILE__) + "/support/all_flats_no_filters.html")) }

  describe "#parse" do
    let(:place_list) { parser.parse }

    it "returns an Array" do
      expect(place_list).to be_a(Array)
      expect(place_list.size).to be(46)
    end

    it "returns an Array of Flats" do
      place_list.each do |place|
        expect(place).to be_a(Moveflat::Place)
      end
    end

    describe "the parsed results" do
      describe "place 1" do
        let(:place) { place_list.first }

        it "has the correct title" do
          expect(place.title).to eq("East Finchley houseshare N2 £995")
        end

        it "has the correct price per month" do
          expect(place.price_per_month).to eq(995)
        end

        it "has the correct link" do
          expect(place.link).to eq("http://moveflat.com/c/432322.htm")
        end

        it "has the correct image URL" do
          expect(place.image_url).to eq("http://www.moveflat.com/_ImageServer.aspx?f=432322A.jpg")
        end

        it "has the correct place type" do
          expect(place.place_type).to eq(:house_share)
        end

        it "has the correct description" do
          expect(place.description).to eq("Lovely large room in a very clean, quiet house. Within 1min walk to tube station & shops. AVAILABLE NOW for short lets. Nice safe neighbourhood, N2. A beautiful home with original wooden flooring ...")
        end

        it "has the correct 'available' date" do
          expect(place.available_from).to eq(Date.today)
        end        

        it "has the correct 'date listed' date" do
          expect(place.date_listed).to eq(Date.new(2014,10,29))
        end

        it "has the correct let short let type" do
          expect(place.short_let).to eq(true)
        end

        it "has the correct council tax included status" do
          expect(place.includes_council_tax?).to eq(false)
        end

        it "has the correct utilities included status" do
          expect(place.includes_utilities?).to eq(false)
        end

        it "has the correct location" do
          expect(place.location).to eq("East Finchley")
        end

        it "has the correct Moveflat ID" do
          expect(place.moveflat_id).to eq("432322")
        end
      end

      describe "place 2" do
        let(:place) { place_list[2] }

        it "has the correct title" do
          expect(place.title).to eq("Whitechapel flatshare E1 £750")
        end

        it "has the correct price per month" do
          expect(place.price_per_month).to eq(750)
        end

        it "has the correct link" do
          expect(place.link).to eq("http://moveflat.com/c/460747.htm")
        end

        it "has the correct image URL" do
          expect(place.image_url).to eq("http://www.moveflat.com/_ImageServer.aspx?f=460747A.jpg")
        end

        it "has the correct place type" do
          expect(place.place_type).to eq(:flat_share)
        end

        it "has the correct description" do
          expect(place.description).to eq("Hi all, I am looking for someone to take over my room in whitechapel. The house is in a great location, 5 min walk to Whitechapel st and 7 min to Shadwell. Loads of busses running close by the hou...")
        end

        it "has the correct 'available' date" do
          expect(place.available_from).to eq(Date.new(2014,11,2))
        end        

        it "has the correct 'date listed' date" do
          expect(place.date_listed).to eq(Date.new(2014,10,29))
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

        it "has the correct locations" do
          expect(place.location).to eq("Whitechapel")
        end

        it "has the correct Moveflat ID" do
          expect(place.moveflat_id).to eq("460747")
        end
      end

      context "when the place's title has 'London' in it" do
        it "doesn't remove 'London' from the title" do
          expect(place_list[3].title).to eq("London bridge flatshare se1 £680")
        end
      end
    end
  end
end
