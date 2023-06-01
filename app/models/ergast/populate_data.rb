class Ergast::PopulateData
  def initialize(client: Ergast::Client.new)
    @client = client
  end

  def populate
    seasons = Ergast::PullSeasons.new(client: @client).record_seasons
    constructors = Ergast::PullConstructors.new(client: @client).record_constructors
    (2020..2022).each do |year|
      Ergast::PullDrivers.new(client: @client).record_drivers(year: year)
    end
  end
end
