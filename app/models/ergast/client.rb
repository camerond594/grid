require "uri"
require "net/http"

class Ergast::Client
  API_URL = "http://ergast.com/api/f1"

  def initialize(connection:)
    @connection = connection
  end

  def get_drivers(year:)
    url = URI("#{API_URL}/#{year}/drivers.json")
    request = Net::HTTP::Get.new(url)
    response = @connection.request(request)

    JSON.parse(response.read_body)
  end
end
