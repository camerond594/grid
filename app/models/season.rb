class Season < ApplicationRecord
  has_many :driver_seasons, class_name: "DriverSeason"
  has_many :drivers, through: :driver_seasons, class_name: "Driver"
  has_many :constructors, -> { distinct }, through: :driver_seasons, class_name: "Constructor"
end
