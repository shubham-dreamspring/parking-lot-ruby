module ParkingLotContants
  TOTAL_CAPACITY_OF_PARKING_LOT = 10
  MINIMUM_PARKING_CHARGE = 100
  CHARGE_MORE_THAN_10_SEC = 200
  CHARGE_MORE_THAN_30_SEC = 300
  CHARGE_MORE_THAN_60_SEC = 500

  DB_DIR = "db"
  DB_CARS = "cars.json"
  DB_EMPTY_SLOTS = "empty_slots.json"
  DB_INVOICES = "invoices.json"

  ERR_NO_EMPTY_SLOTS = "NO SLOTS AVAILABLE!! Please Come back Later"
  ERR_INVALID_REGISTRATION_NO = "Invalid Registration number!! Please enter 10 character long with initial two character alphabet with no spaces and special characters"
  ERR_CAR_NOT_FOUND = "It seems car has not been parked"
  
  SUCCESS_PARK_CAR = "Car has been parked at"
  SUCCESS_UNPARK_CAR = "Car has been unparked! \nHave a good day :)"
end
