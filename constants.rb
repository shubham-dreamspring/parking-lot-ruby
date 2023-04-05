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
  ERR_INVOICE_NOT_FOUND = "No invoice with this id found!!"

  SUCCESS_PARK_CAR = "Car has been parked at"
  SUCCESS_UNPARK_CAR = "Car has been unparked! \nHave a good day :)"

  def self.INVOICE_PRINT_FORMAT(invoice_id:, registration_no:, amount:, exit_time:, entry_time:)
    s = <<~END_OF_STRING
      ============================================
           INVOICE (id :- #{invoice_id})
        
        Registration Number: #{registration_no}
        AMOUNT: #{amount}
        DURATION: #{exit_time - entry_time} seconds
        ENTRY TIME: #{Time.at(entry_time).strftime("%m/%d/%Y %I:%M %p")}
        EXIT TIME: #{Time.at(exit_time).strftime("%m/%d/%Y %I:%M %p")}
      ============================================

    END_OF_STRING
  end

  def self.CARS_PRINT_FORMAT(cars)
    s = <<~END_OF_STRING
    ============================================
           Found #{cars.length} cars
    ============================================
    Registration Number ===>  Slot
    --------------------------------------------
    #{cars.reduce('') { |res, car| res << "#{car[:registration_no]}          ===>  #{car[:slot_id]}\n" }}
    ============================================
    END_OF_STRING
  end
end
