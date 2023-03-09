class Ergast::PullSeasons
  def initialize(client: Ergast::Client.new)
    @client = client
  end

  def record_seasons
    seasons = @client.get_seasons["MRData"]["SeasonTable"]["Seasons"]
    
    seasons.each do |season|
      Season.find_or_create_by({
        year: season["season"],
        url: season["url"]
      })
    end
  end
end
