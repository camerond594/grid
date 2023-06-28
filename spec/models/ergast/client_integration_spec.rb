require 'rails_helper'

RSpec.describe Ergast::Client, type: :model do
  describe "#get_drivers" do
    subject { described_class.new.get_drivers(year: 2022) }

    it "gets the drivers", :vcr do
      response = subject["MRData"]["DriverTable"]
      expect(response["season"]).to eq("2022")
      expect(response["Drivers"].first).to include(
        {
          "driverId"=>"albon",  
          "permanentNumber"=>"23",
          "code"=>"ALB",        
          "url"=>"http://en.wikipedia.org/wiki/Alexander_Albon",
          "givenName"=>"Alexander",
          "familyName"=>"Albon",
          "dateOfBirth"=>"1996-03-23",
          "nationality"=>"Thai"
        }
      )
    end
  end

  describe "#get_seasons" do
    subject { described_class.new.get_seasons }

    it "gets the seasons", :vcr do
      response = subject["MRData"]["SeasonTable"]
      expect(response["Seasons"].first).to include(
        {
          "season"=> "1950",
          "url"=> "http://en.wikipedia.org/wiki/1950_Formula_One_season"
        }
      )
    end
  end

  describe "#get_constuctors_for_driver" do
    subject { described_class.new.get_constuctors_for_driver(year: 2022, driver_id: "alonso") }

    it "gets all constructors for a given driver", :vcr do
      response = subject["MRData"]["ConstructorTable"]
      expect(response["Constructors"].first).to include(
        {
          "constructorId" => "alpine",
          "name" => "Alpine F1 Team",
          "nationality" => "French",
          "url" => "http://en.wikipedia.org/wiki/Alpine_F1_Team"
        }
      )
    end
  end
end
