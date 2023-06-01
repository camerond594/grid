require 'rails_helper'

RSpec.describe Ergast::PopulateData, type: :model do
  describe "#populate" do
    subject { described_class.new(client: client).populate }

    let(:client) { instance_double(Ergast::Client) }
    let(:pull_seasons) { instance_double(Ergast::PullSeasons, record_seasons:nil) }
    let(:pull_constructors) { instance_double(Ergast::PullConstructors, record_constructors:nil) }

    before do
      allow(Ergast::PullConstructors).to receive(:new).with(client: client).and_return(pull_constructors)
      allow(Ergast::PullSeasons).to receive(:new).with(client: client).and_return(pull_seasons)
    end

    it "calls the PullSeasons class" do
      expect(Ergast::PullSeasons).to receive(:new).with(client: client).and_return(pull_seasons)
      expect(pull_seasons).to receive(:record_seasons)

      subject
    end

    it "calls the PullConstructors class" do
      expect(Ergast::PullConstructors).to receive(:new).with(client: client).and_return(pull_constructors)
      expect(pull_constructors).to receive(:record_constructors)

      subject
    end
  end
end
