# frozen_string_literal: true
require_relative '../utils/custom_errors'

class Slot < CustomOrm
  include CustomErrors

  def self.doc
    DB_SLOTS
  end

  def doc
    DB_SLOTS
  end

  attr_accessor :id, :timestamp, :vehicle_id

  def initialize(id, vehicle_id = nil, timestamp = nil)
    @id = id
    @timestamp = timestamp
    @vehicle_id = vehicle_id
  end

  def empty?
    @vehicle_id.nil?
  end

  def car
    car = Car.find('id', @vehicle_id)
    raise CarNotFound, 'car is not parked with this id' if car.nil?

    Car.new(car['registration_no'], car['id'])
  end

  def self.empty_slot
    slots = find_all
    empty_slots = slots.select(&:empty?)
    raise CustomErrors::NoEmptySlot if (empty_slots.empty?)

    Slot.new(empty_slots.first.id, empty_slots.first.timestamp, empty_slots.first.vehicle_id)
  end

  def self.filled_slot(sort_property = nil, limit = nil)
    slots = find_all(sort_property, limit)
    slots
      .filter { |slot| !slot.empty? }
  end

  def self.find_all(sort_property = nil, limit = nil)
    slots = super(sort_property, limit)
    slots.map { |slot| Slot.new(slot['id'], slot['vehicle_id'], slot['timestamp']) }
  end

  def self.find(property_name, property_value)
    slot = super(property_name, property_value)

    raise RecordNotFound, 'No slot found !' if slot.nil?

    Slot.new(slot['id'], slot['vehicle_id'], slot['timestamp'])

  end

  def self.vacant_slot(slot)
    slot.timestamp = nil
    slot.vehicle_id = nil
    slot.update
  end

  def self.reset
    data = []
    TOTAL_CAPACITY_OF_PARKING_LOT.times { |index| data.push({ id: index + 1, timestamp: nil, vehicle_id: nil }) }
    super(data)
  end
end

