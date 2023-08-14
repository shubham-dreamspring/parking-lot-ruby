# frozen_string_literal: true
require_relative '../utils/custom_errors'
require_relative '../utils/custom_orm'

class Slot < CustomOrm
  include CustomErrors
  attr_reader :id, :timestamp, :vehicle_id

  def initialize(id:, vehicle_id: nil, timestamp: nil)
    @id = id
    @timestamp = timestamp
    @vehicle_id = vehicle_id
  end

  def empty?
    @vehicle_id.nil?
  end

  def car
    Car.find('id', @vehicle_id)
  end

  def self.empty_slot
    slots = find_all
    slot = slots.find(&:empty?)
    raise NoEmptySlot if slot.nil?

    slot
  end

  def self.filled_slots(sort_property = nil, limit = nil)
    slots = find_all(sort_property, limit)
    slots.filter { |slot| !slot.empty? }
  end

  def vacant_slot
    @timestamp = nil
    @vehicle_id = nil
    update
  end

  def occupy_slot(car_id)
    @vehicle_id = car_id
    @timestamp = Time.now
    update
  end

  def self.reset
    data = []
    TOTAL_CAPACITY_OF_PARKING_LOT.times { |index| data.push({ id: index + 1, timestamp: nil, vehicle_id: nil }) }
    super(data)
  end
end

