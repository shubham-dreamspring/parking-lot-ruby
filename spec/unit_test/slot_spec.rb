require_relative '../../models/slot'
require_relative '../../models/car'
require_relative '../../models/invoice'

describe 'Slots' do
  before(:each) do
    ParkingLot.reset
  end

  after(:each) do
    ParkingLot.reset
  end

  describe '#empty_slot' do
    it 'will give a empty slot' do
      slot = Slot.empty_slot

      expect(slot.empty?).to be_truthy
    end
  end

  describe '#filled_slots' do
    it 'will give filled slots' do
      car = Car.new(registration_no: 'WW12345678')
      ParkingLot.park(car)

      slots = Slot.filled_slots

      expect(slots.find { |slot| slot.vehicle_id == car.id }).not_to be_nil
    end
  end

  describe '#car' do
    it 'will return car parked on a slot' do
      car = Car.new(registration_no: 'WW12345678')
      parked_car = ParkingLot.park(car)
      slot = Slot.find('vehicle_id', car.id)

      car_at_slot = slot.car
      registration_no = car_at_slot.registration_no

      expect(registration_no).to eql(parked_car[:registration_no])
    end
  end

  describe '#vacant_slot' do
    it 'will remove vehicle_id and timestamp from slot' do
      slot = Slot.new(id: 11, vehicle_id: '342-3424-34234', timestamp: 2343242342)
      slot.create

      slot.vacant_slot

      expect(slot.vehicle_id).to be_nil
      expect(slot.timestamp).to be_nil
    end
  end

  describe '#occupy_slot' do
    it 'will update vehicle_id and timestamp' do
      car_id = '347298-34234-234'
      slot = Slot.new(id: 11, vehicle_id: nil, timestamp: nil)
      slot.create

      slot.occupy_slot(car_id)

      expect(slot.vehicle_id).to be car_id
      expect(slot.timestamp).not_to be_nil
    end
  end
end
