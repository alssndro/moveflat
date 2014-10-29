require 'spec_helper'

RSpec.describe Moveflat::Scraper do
  let(:scraper) { Moveflat::Scraper.new }

  describe "#scrape_list" do
    context "when the URL is valid" do
      let(:place_list) { scraper.scrape_list("http://www.moveflat.com/london-flat/flatshare-flatmate/orderon/all/property/Box/") }

      it "returns an Array" do
        expect(place_list).to be_a(Array)
        expect(place_list.size).to be(233)
      end

      it "returns an Array of Flats" do
        place_list.each do |place|
          expect(place).to be_a(Moveflat::Place)
        end
      end

      describe "the scraped results" do
        let(:place) { place_list.first }

        it "has the correct title" do
          expect(place.title).to eq("East Finchley houseshare N2 £995")
        end

        it "has the correct link" do
          expect(place.link).to eq("http://moveflat.com/c/432322.htm")
        end

        it "has the correct image URL" do
          expect(place.image_url).to eq("http://moveflat.com/_ImageServer.aspx?f=432322A-+.jpg")
        end

        it "has the correct place type" do
          expect(place.place_type).to eq(:house_share)
        end

        it "has the correct description" do
          expect(place.description).to eq("Lovely large room in a very clean, quiet house. Within 1min walk to tube station & shops. AVAILABLE NOW for short lets. Nice safe neighbourhood, N2. A beautiful home with original wooden flooring ...")
        end

        it "has the correct availability" do
          expect(place.available_from).to eq(Date.new(2014,10,29))
        end        

        it "has the correct 'date listed' date" do
          expect(place.date_listed).to eq(Date.new(2014,10,29))
        end
      end
    end

    context "when the URL is not valid" do
      it "raises an exception when the URL does not contain moveflat.com" do
        expect { scraper.scrape_list("http://google.com") }.to raise_exception(Moveflat::InvalidUrl)
      end

      it "raises an exception when the URL contains moveflat.com but is malformed" do
        expect { scraper.scrape_list("http://moveflatt.com") }.to raise_exception(Moveflat::InvalidUrl)
      end
    end
  end
end
