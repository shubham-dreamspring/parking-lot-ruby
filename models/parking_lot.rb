require_relative 'car'
require_relative 'slot'
require_relative 'invoice'
require_relative '../utils/custom_errors'

class ParkingLot
  include CustomErrors

  def self.initialise_db
    CustomOrm.initialise_db
  end

  def self.reset
    Car.reset
    Slot.reset
  end

  def self.park(car)
    car.create

    slot = Slot.empty_slot
    slot.vehicle_id = car.id
    slot.timestamp = Time.now
    slot.update

    {
      registration_no: car.registration_no,
      park_timestamp: slot.timestamp,
      slot_id: slot.id,
    }
  end

  def self.unpark(car)
    raise CarNotFound, 'Car is not parked' unless car.already_exist?

    slot = Slot.find('vehicle_id', car.id)
    car_parked_time = slot.timestamp
    Slot.vacant_slot(slot)
    Car.delete('id', car.id)
    Invoice.new(car.registration_no, car_parked_time)
  end

  def self.parked_cars(sort_property = nil, limit = nil)

    slots = Slot.filled_slot(sort_property, limit)
    slots.map do |slot|
      {
        slot_id: slot.id,
        registration_no: slot.car.registration_no,
      }
    end
  end
end
