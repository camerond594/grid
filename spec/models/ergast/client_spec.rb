require 'rails_helper'

RSpec.describe Ergast::Client, type: :model do
  describe "#get_drivers" do
    subject { described_class.new(connection: connection).get_drivers(year: 2022) }

    let(:connection) { instance_double(Net::HTTP) }
    let(:response) { instance_double(Net::HTTPResponse, read_body: '{"name": "Charles LeClerc"}' ) }

    it "makes a GET on the correct URL" do
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

    it "makes a GET on the correct URL" do
      expect(connection).to receive(:request) do |request|
        expect(request).to be_a(Net::HTTP::Get)
        expect(request.uri.to_s).to eq "http://ergast.com/api/f1/seasons.json"
      end.and_return(response)
      
      subject
    end

    it "returns the appropriate body" do
      allow(connection).to receive(:request).and_return(response)

      expect(subject).to eq({ "season" => "2001", "url" => "https://en.wikipedia.org/wiki/2001_Formula_One_season" })
    end
  end

  describe "#get_constuctors" do
    subject { described_class.new(connection: connection).get_constructors }

    let(:connection) { instance_double(Net::HTTP) }
    let(:response) { instance_double(Net::HTTPResponse, read_body: '{"constructors": [{"constructorId": "aston_martin", "url": "http://en.wikipedia.org/wiki/Aston_Martin_in_Formula_One", "name": "Aston Martin", "nationality": "British"}]}' ) }

    it "makes a GET on the correct URL" do
      expect(connection).to receive(:request) do |request|
        expect(request).to be_a(Net::HTTP::Get)
        expect(request.uri.to_s).to eq "http://ergast.com/api/f1/constructors.json?limit=1000"
      end.and_return(response)
      
      subject
    end

    it "returns the appropriate body" do
      allow(connection).to receive(:request).and_return(response)

      expect(subject).to eq({
        "constructors" => [
            {
              "constructorId" => "aston_martin",
              "url" => "http://en.wikipedia.org/wiki/Aston_Martin_in_Formula_One",
              "name" => "Aston Martin",
              "nationality" => "British"
            }
          ]
        }
      )
    end
  end

  describe "#get_constuctors_for_driver" do
    subject { described_class.new(connection: connection).get_constuctors_for_driver(year: year, driver_id: driver_id) }

    let(:connection) { instance_double(Net::HTTP) }
    let(:response) { instance_double(Net::HTTPResponse, read_body: '{"constructors": [{"constructorId": "aston_martin", "url": "http://en.wikipedia.org/wiki/Aston_Martin_in_Formula_One", "name": "Aston Martin", "nationality": "British"}]}' ) }
    let(:driver_id) { "alonso" }
    let(:year) { 2022 }

    it "makes a GET on the correct URL" do
      expect(connection).to receive(:request) do |request|
        expect(request).to be_a(Net::HTTP::Get)
        expect(request.uri.to_s).to eq "http://ergast.com/api/f1/2022/drivers/alonso/constructors.json"
      end.and_return(response)
      
      subject
    end

    it "returns the appropriate body" do
      allow(connection).to receive(:request).and_return(response)

      expect(subject).to eq({
        "constructors" => [
            {
              "constructorId" => "aston_martin",
              "url" => "http://en.wikipedia.org/wiki/Aston_Martin_in_Formula_One",
              "name" => "Aston Martin",
              "nationality" => "British"
            }
          ]
        }
      )
    end
  end
end
