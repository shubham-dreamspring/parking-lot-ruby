# frozen_string_literal: true

require_relative '../utils/orm'
require_relative '../app_constants'
require_relative '../models/invoice'

# Model for Parking Lot
class ParkingLot
  include ParkingLotContants

  def self.fetch_empty_slot
    slots = CustomOrm.read_db_file(db_name: DB_EMPTY_SLOTS)
    raise ERR_NO_EMPTY_SLOTS if slots.empty?

    slot = slots.pop
    CustomOrm.delete_last_element
    slot
  end

  def park(car)
    raise "#{ERR_CAR_ALREADY_PARKED} at #{car.slot_id}" if car.slot_id

    car.slot_id = ParkingLot.fetch_empty_slot
    car.push_to_db
    puts "#{SUCCESS_PARK_CAR} #{car.slot_id}"
  end

  def unpark(car)
    raise ERR_CAR_NOT_FOUND if car.slot_id.nil?

    CustomOrm.write_db_file(db_name: DB_EMPTY_SLOTS, data: car.slot_id)
    CustomOrm.delete_element_by_key(db_name: DB_CARS, key: car.registration_no)
    puts SUCCESS_UNPARK_CAR
    Invoice.new(car).print_invoice
  end
end
