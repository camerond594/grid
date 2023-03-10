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
      new_driver.seasons << season
      new_driver.save!
    end
  end
end
