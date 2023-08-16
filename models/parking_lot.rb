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
    slot.occupy_slot(car.id)

    {
      registration_no: car.registration_no,
      park_timestamp: slot.timestamp,
      slot_id: slot.id,
    }
  end

  def self.unpark(car)
    raise CarNotFound unless car.already_exist?

    car = Car.find('registration_no', car.registration_no)
    slot = Slot.find('vehicle_id', car.id)
    raise RecordNotFound, 'No slot with this car found!' if slot.nil?

    car_parked_time = slot.timestamp
    slot.vacant_slot
    Car.delete('id', car.id)
    invoice = Invoice.new(registration_no: car.registration_no, entry_time: car_parked_time)
    invoice.create
    invoice
  end

  def self.parked_cars(sort_property = nil, limit = nil)

    slots = Slot.filled_slots(sort_property, limit)
    slots.map do |slot|
      {
        slot_id: slot.id,
        registration_no: slot.car.registration_no,
      }
    end
  end
end
