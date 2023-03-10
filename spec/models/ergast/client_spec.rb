require 'rails_helper'

RSpec.describe Ergast::Client, type: :model do
  describe "#get_drivers" do
    subject { described_class.new(connection: connection).get_drivers(year: 2022) }

    let(:connection) { instance_double(Net::HTTP) }
    let(:response) { instance_double(Net::HTTPResponse, read_body: '{"name": "Charles LeClerc"}' ) }

    it "calls the connection" do
      expect(connection).to receive(:request) do |request|
        expect(request).to be_a(Net::HTTP::Get)
        expect(request.uri.to_s).to eq "http://ergast.com/api/f1/2022/drivers.json"
      end.and_return(response)

      expect(subject).to eq({ "name" => "Charles LeClerc" })
    end
  end

  describe "#get_seasons" do
    subject { described_class.new(connection: connection).get_seasons }

    let(:connection) { instance_double(Net::HTTP) }
    let(:response) { instance_double(Net::HTTPResponse, read_body: '{"season": "2001", "url": "https://en.wikipedia.org/wiki/2001_Formula_One_season"}' ) }

    it "calls the connection" do
      expect(connection).to receive(:request) do |request|
        expect(request).to be_a(Net::HTTP::Get)
        expect(request.uri.to_s).to eq "http://ergast.com/api/f1/seasons.json"
      end.and_return(response)

      expect(subject).to eq({ "season" => "2001", "url" => "https://en.wikipedia.org/wiki/2001_Formula_One_season" })
    end
  end
end
