require 'rails_helper'

RSpec.describe Ergast::PullDrivers, type: :model do
  describe "#record_drivers" do
    subject { described_class.new(client: client).record_drivers(year: 2022) }

    let(:client) { instance_double(Ergast::Client) }
    let!(:season) { Season.create(year: 2022, url: "a-url") }
    let!(:constructor) { Constructor.create(name: "Aston Martin", url: "a-url") }

    it "records the drivers for the given year" do
      allow(client).to receive(:get_drivers).and_return(
        {
          "MRData"=> {
            "xmlns"=>"http://ergast.com/mrd/1.5",
            "series"=>"f1",            
            "url"=>"http://ergast.com/api/f1/2022/drivers.json",
            "limit"=>"30",             
            "offset"=>"0",             
            "total"=>"22",             
            "DriverTable"=> {
              "season"=>"2022",        
              "Drivers"=> [
                {
                  "driverId"=>"vettel",
                  "permanentNumber"=>"5",
                  "code"=>"VET",
                  "url"=>"http://en.wikipedia.org/wiki/Sebastian_Vettel",
                  "givenName"=>"Sebastian",
                  "familyName"=>"Vettel",
                  "dateOfBirth"=>"1987-07-03",
                  "nationality"=>"German"
                }
              ]
            }
          }
        }
      )

      allow(client).to receive(:get_constuctors_for_driver).and_return(
        {
          "MRData"=> {
            "xmlns"=>"http://ergast.com/mrd/1.5",
            "series"=>"f1",            
            "url"=>"http://ergast.com/api/f1/2022/drivers.json",
            "limit"=>"30",             
            "offset"=>"0",             
            "total"=>"22",             
            "ConstructorTable"=> {
              "season"=>"2022",        
              "Constructor"=> [
                {
                  "Constructor Name" => "Aston Martin"
                }
              ]
            }
          }
        }
      )

      subject

      expect(Driver.count).to be 1
      
      driver = Driver.first
      expect(driver.driver_id).to eq "vettel"
      expect(driver.permanent_number).to eq 5
      expect(driver.code).to eq "VET"
      expect(driver.url).to eq "http://en.wikipedia.org/wiki/Sebastian_Vettel"
      expect(driver.given_name).to eq "Sebastian"
      expect(driver.family_name).to eq "Vettel"
      expect(driver.nationality).to eq "German"
      expect(driver.date_of_birth.to_s).to eq "1987-07-03"

      expect(driver.seasons).to include season
    end
  end
end
