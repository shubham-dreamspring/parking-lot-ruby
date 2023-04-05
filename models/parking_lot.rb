require_relative "../utils/orm"
require_relative "../constants.rb"

class ParkingLot
  include ParkingLotContants

  def self.getEmptySlot()
    slots = CustomOrm.read_db_file(db_name: DB_EMPTY_SLOTS)
    slot = slots.pop
    CustomOrm.delete_last_element
    slot
  end

  def park(car)
    car.slot_id = ParkingLot.getEmptySlot()
    car.push_to_db()
    puts "Car has been parked!"
  end

  def unpark(car)
    CustomOrm.write_db_file(db_name: DB_EMPTY_SLOTS, data: car.slot_id)
    CustomOrm.delete_element_by_key(db_name: DB_CARS, key: car.registration_no)
    puts "Car has been unparked!"
  end
end
