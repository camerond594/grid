require "uri"
require "net/http"

class Ergast::Client
  HOST = "ergast.com"
  API_URL = "http://#{HOST}/api/f1"
  LIMIT_1000 = "limit=1000"

  def initialize(connection: Net::HTTP.new(HOST))
    @connection = connection
  end

  def get_drivers(year:)
    url = URI("#{API_URL}/#{year}/drivers.json")
    request = Net::HTTP::Get.new(url)
    response = @connection.request(request)

    JSON.parse(response.read_body)
  end

  def get_seasons
    url = URI("#{API_URL}/seasons.json")
    request = Net::HTTP::Get.new(url)
    response = @connection.request(request)

    JSON.parse(response.read_body)
  end

  def get_constructors
    url = URI("#{API_URL}/constructors.json?#{LIMIT_1000}")
    request = Net::HTTP::Get.new(url)
    response = @connection.request(request)

    JSON.parse(response.read_body)
  end

  def get_constuctors_for_driver(year:, driver_id:)
    url = URI("#{API_URL}/#{year}/drivers/#{driver_id}/constructors.json")
    request = Net::HTTP::Get.new(url)
    response = @connection.request(request)

    JSON.parse(response.read_body)
  end
end
