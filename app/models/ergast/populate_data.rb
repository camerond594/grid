class Ergast::PopulateData
  def initialize(client: Ergast::Client.new)
    @client = client
  end

  def populate
    seasons = Ergast::PullSeasons.new(client: @client).record_seasons
  end
end
