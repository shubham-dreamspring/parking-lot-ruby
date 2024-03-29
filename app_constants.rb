# frozen_string_literal: false

# module conatining constants used in app
module ParkingLotConstants
  TEST_MODE = ENV['MODE'] == 'test'
  TOTAL_CAPACITY_OF_PARKING_LOT = 10

  MINIMUM_PARKING_CHARGE = 100
  CHARGE_MORE_THAN_10_SEC = 200
  CHARGE_MORE_THAN_30_SEC = 300
  CHARGE_MORE_THAN_60_SEC = 500

  TEST_DB_DIR = 'db-test'.freeze

  DB_DIR = TEST_MODE ? TEST_DB_DIR : 'db'
  DB_CARS = 'cars.json'.freeze
  DB_SLOTS = 'slots.json'.freeze
  DB_INVOICES = 'invoices.json'.freeze
  DB_FILE_FORMAT = '.json'.freeze
  ERR_NO_EMPTY_SLOTS = 'NO SLOTS AVAILABLE!! Please Come back Later'.freeze
  ERR_INVALID_REGISTRATION_NO = 'Invalid Registration number!!
  Please enter 10 character long
  with initial two character alphabets
  with no spaces and special characters'.freeze
  ERR_CAR_NOT_FOUND = 'It seems car has not been parked'.freeze
  ERR_INVOICE_NOT_FOUND = 'No invoice with this id found!!'.freeze
  ERR_RECORD_NOT_FOUND = 'No Record found'.freeze
  ERR_CAR_ALREADY_PARKED = 'Car is already parked'.freeze
  ERR_NO_INVOICES = 'No invoice yet generated !!'.freeze
  ERR_INVALID_INPUT = 'Invalid Input'.freeze
  SUCCESS_PARK_CAR = 'Car has been parked at'.freeze
  SUCCESS_UNPARK_CAR = "Car has been unparked! \nHave a good day ".freeze

  def self.INVOICE_PRINT_FORMAT(id:, registration_no:, amount:, exit_time:, entry_time:)
    "
      ============================================
           INVOICE (id :- #{id})

        Registration Number: #{registration_no}
        AMOUNT: #{amount}
        DURATION: #{exit_time - entry_time} seconds
        ENTRY TIME: #{Time.at(entry_time).strftime('%m/%d/%Y %I:%M %p')}
        EXIT TIME: #{Time.at(exit_time).strftime('%m/%d/%Y %I:%M %p')}
      ============================================
"
  end

  def self.CARS_PRINT_FORMAT(cars)
    "
      ============================================
             Found #{cars.length} cars
      ============================================
      Registration Number ===>  Slot
      --------------------------------------------
      #{cars.reduce('') { |res, car| res << "#{car[:registration_no]}          ===>  #{car[:slot_id]}\n      " }}
      ============================================
    "
  end
end
