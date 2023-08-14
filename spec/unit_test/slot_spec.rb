require_relative '../../models/slot'
require_relative '../../models/car'
require_relative '../../models/invoice'
require 'pry'
require 'pry-nav'

describe 'Slots' do
  before(:all) do
    ParkingLot.reset
  end

  after(:each) do
    ParkingLot.reset
  end

  it 'will give empty slot' do
    slot = Slot.empty_slot

    expect(slot.empty?).to be_truthy
  end

  context 'when car is parked' do
    it 'will give filled slots with parked cars' do
      # binding.pry
      car = Car.new('WW12345678')
      ParkingLot.park(car)
      slots = Slot.filled_slot

      expect(slots.find { |slot| slot.vehicle_id == car.id }).not_to be_nil
    end

    it 'will return car parked on a slot' do
      car = Car.new('WW12345678')
      parked_car = ParkingLot.park(car)
      slot = Slot.find('id', car.id)
      car_at_slot = slot.car

      registration_no = car_at_slot.registration_no

      expect(registration_no).to eq(parked_car['registration_no'])
    end
  end
end
