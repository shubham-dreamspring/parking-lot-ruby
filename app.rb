require_relative "models/car"
require_relative "models/parking_lot"


car = Car.new("UP12345678")

ParkingLot.new.unpark(car);