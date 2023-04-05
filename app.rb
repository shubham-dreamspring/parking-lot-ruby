require_relative "models/car"
require_relative "models/parking_lot"

car = Car.new("UP12345678")
ParkingLot.new.unpark(car)

# ParkingLot.new.park(car)
# car = Car.new("MP12345678")

# ParkingLot.new.unpark(car); 
# car = Car.new("AA3A567890")

# ParkingLot.new.unpark(car); 
# car = Car.new("BG12345678")

# ParkingLot.new.park(car)
