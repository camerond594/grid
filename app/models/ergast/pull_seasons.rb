class Ergast::PullSeasons
  def initialize(client: Ergast::Client.new)
    @client = client
  end

  def record_seasons
    seasons = @client.get_seasons["MRData"]["SeasonTable"]["Seasons"]
    
    seasons.each do |season|
      Season.create({
        year: season["season"],
        url: season["url"]
      })
    end
  end
end
