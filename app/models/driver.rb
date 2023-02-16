class Driver < ApplicationRecord
  has_many :driver_seasons, class_name: "DriverSeason"
  has_many :seasons, through: :driver_seasons, class_name: "Season"
end
