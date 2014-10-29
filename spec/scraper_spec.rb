require 'spec_helper'

RSpec.describe Moveflat::Scraper do
  let(:scraper) { Moveflat::Scraper.new }

  describe "#scrape_item" do
    context "when the URL is valid" do
      let(:item) { scraper.fetch_by_url("http://www.uniqlo.com/uk/store/goods/136454") }

      it "returns an UniqloItem and its title" do
        expect(item.title).to eq("MEN +J Premium Down Parka")
      end

      it "returns an UniqloItem and its sizes available" do
        expect(item.sizes).to eq(["xs", "s", "m", "l", "xl"])
      end
      
      it "returns an UniqloItem and its price" do
        expect(item.price).to eq("£179.90")
      end
      
      it "returns an UniqloItem and its colours available" do
        expect(item.colours).to eq(["black", "navy"])
      end
    end

    context "when the URL is not valid" do
      it "raises an exception when the URL does not contain uniqlo.com" do
        expect { scraper.fetch_by_url("http://google.com") }.to raise_exception(UniqloStockChecker::InvalidItemUrl)
      end

      it "raises an exception when the URL contains uniqlo.com but is malformed" do
        expect { scraper.fetch_by_url("http://uniqloo.com") }.to raise_exception(UniqloStockChecker::InvalidItemUrl)
      end
    end
  end
end
