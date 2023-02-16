class Season < ApplicationRecord
  has_many :driver_seasons, class_name: "DriverSeason"
  has_many :drivers, through: :driver_seasons, class_name: "Driver"
end
