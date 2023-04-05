require_relative "../utils/orm.rb"
require_relative "../constants.rb"

class Car
  include ParkingLotContants

  attr_accessor :slot_id
  attr_reader :registration_no, :entry_time

  def initialize(registration_no)
    Car.validate_registration_no(registration_no)
    @registration_no = registration_no
    @slot_id = nil
    @entry_time = Time.now.to_i
    car_data = Car.find_by_registration_no(registration_no)
    if (car_data)
      @slot_id = car_data["slot_id"]
      @entry_time = car_data["entry_time"]
    end
  end

  def self.find_by_registration_no(registration_no)
    cars = CustomOrm.read_db_file(db_name: DB_CARS)
    cars[registration_no]
  end

  def push_to_db()
    if (@slot_id.nil?)
      raise "Slot is not permitted"
    end
    car = { @registration_no => {
      "slot_id" => @slot_id,
      "entry_time" => @entry_time,
    } }
    CustomOrm.write_db_file(db_name: DB_CARS, data: car)
  end

  def self.validate_registration_no(registration_no)
    unless Regexp.new(/[a-zA-Z]{2}[a-zA-Z0-9]{8}/).match?(registration_no)
      raise ERR_INVALID_REGISTRATION_NO
    end
  end

  def self.get_all
    cars = CustomOrm.read_db_file(db_name: DB_CARS)
    car_print = []
    cars.each { |registration_no, car| car_print.push({ registration_no:, slot_id: car["slot_id"] }) }
    puts ParkingLotContants.CARS_PRINT_FORMAT(car_print)
  end
end
