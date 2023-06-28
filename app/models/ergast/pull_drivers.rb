class Ergast::PullDrivers
  def initialize(client: Ergast::Client.new)
    @client = client
  end

  def record_drivers(year:)
    drivers = @client.get_drivers(year: year)["MRData"]["DriverTable"]["Drivers"]

    drivers.each do |driver|
      new_driver = Driver.find_or_create_by(
        {
          driver_id: driver["driverId"],
          code: driver["code"],
          url: driver["url"],
          permanent_number: driver["permanentNumber"],
          given_name: driver["givenName"],
          family_name: driver["familyName"],
          date_of_birth: driver["dateOfBirth"],
          nationality: driver["nationality"],
        }
      )
      season = Season.find_by(year: year)
      driver_season = new_driver.driver_seasons.find_by(season: season)

      if driver_season.nil?
        constructors_data = @client.get_constuctors_for_driver(year: year, driver_id: driver["driverId"])["MRData"]["ConstructorTable"]["Constructors"]

        if constructors_data.any?
          constructor = Constructor.find_by(name: constructors_data[0]["name"])
        end
      end

      unless driver_season
        new_driver.driver_seasons.create(season: season, constructor: constructor)
      end

      new_driver.save
    end
  end
end
