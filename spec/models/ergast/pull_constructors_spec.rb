require 'rails_helper'

RSpec.describe Ergast::PullConstructors, type: :model do
  describe "#record_constructors" do
    subject { described_class.new(client: client).record_constructors }

    let(:client) { instance_double(Ergast::Client) }

    it "records the constructors" do
      allow(client).to receive(:get_constructors).and_return(
        {
          "MRData" => {
              "xmlns" => "http://ergast.com/mrd/1.5",
              "series" => "f1",
              "url" => "http://ergast.com/api/f1/constructors/alpine.json",
              "limit" => "30",
              "offset" => "0",
              "total" => "1",
              "ConstructorTable" => {
                  "constructorId" => "alpine",
                  "Constructors" => [
                      {
                          "constructorId" => "alpine",
                          "url" => "http://en.wikipedia.org/wiki/Alpine_F1_Team",
                          "name" => "Alpine F1 Team",
                          "nationality" => "French"
                      }
                  ]
              }
          }
      }
      )

      subject

      expect(Constructor.count).to be 1
      
      constructor = Constructor.first
      expect(constructor.name).to eq "Alpine F1 Team"
      expect(constructor.nationality).to eq "French"
      expect(constructor.url).to eq "http://en.wikipedia.org/wiki/Alpine_F1_Team"
    end
  end
end
