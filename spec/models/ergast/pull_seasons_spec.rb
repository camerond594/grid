require 'rails_helper'

RSpec.describe Ergast::PullSeasons, type: :model do
  describe "#record_seasons" do
    subject { described_class.new(client: client).record_seasons }

    let(:client) { instance_double(Ergast::Client) }

    it "records the seasons" do
      allow(client).to receive(:get_seasons).and_return(
        {
          "MRData"=> {
            "xmlns"=> "http://ergast.com/mrd/1.5",
            "series"=> "f1",
            "url"=> "http://ergast.com/api/f1/seasons.json",
            "limit"=> "1",
            "offset"=> "0",
            "total"=> "74",
            "SeasonTable"=> {
                "Seasons"=> [
                    {
                        "season"=> "1950",
                        "url"=> "http://en.wikipedia.org/wiki/1950_Formula_One_season"
                    }
                ]
            }
          }
        }
      )

      subject


      expect(Season.count).to be 1
      
      season = Season.first

      expect(season.year).to eq "1950"
      expect(season.url).to eq "http://en.wikipedia.org/wiki/1950_Formula_One_season"
    end
  end
end
