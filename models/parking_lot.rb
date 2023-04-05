require_relative "../utils/orm"
require_relative "../constants.rb"
require_relative "../models/invoice.rb"

class ParkingLot
  include ParkingLotContants

  def self.getEmptySlot()
    slots = CustomOrm.read_db_file(db_name: DB_EMPTY_SLOTS)
    raise ERR_NO_EMPTY_SLOTS if slots.size.zero?
    slot = slots.pop
    CustomOrm.delete_last_element
    slot
  end

  def park(car)
    car.slot_id = ParkingLot.getEmptySlot()
    car.push_to_db()
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
