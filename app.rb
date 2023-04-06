# frozen_string_literal: true

require_relative 'models/car'
require_relative 'models/parking_lot'
require_relative 'models/invoice'
# car = Car.new("UP12345678")
# ParkingLot.new.unpark(car)

car = Car.new('MP12345678')
ParkingLot.new.park(car)

# car = Car.new("AA3A567890")
# ParkingLot.new.park(car);

# car = Car.new("BG12345678")
# ParkingLot.new.park(car)

# Invoice.find_all
Invoice.find_by_id('IN1680674937')

# Car.find_all
