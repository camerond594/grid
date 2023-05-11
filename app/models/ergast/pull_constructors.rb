class Ergast::PullConstructors
  def initialize(client: Ergast::Client.new)
    @client = client
  end

  def record_constructors
    constructors = @client.get_constructors["MRData"]["ConstructorTable"]["Constructors"]

    constructors.each do |constructor|
      Constructor.find_or_create_by({
        name: constructor["name"],
        nationality: constructor["nationality"],
        url: constructor["url"]
      })
    end
  end
end
