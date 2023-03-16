require 'rails_helper'

RSpec.describe Ergast::PopulateData, type: :model do
  describe "#populate" do
    subject { described_class.new(client: client).populate }

    let(:client) { instance_double(Ergast::Client) }
    let(:pull_seasons) { instance_double(Ergast::PullSeasons) }

    it "calls the PullSeasons class" do
      expect(Ergast::PullSeasons).to receive(:new).with(client: client).and_return(pull_seasons)
      expect(pull_seasons).to receive(:record_seasons)

      subject
    end
  end
end
