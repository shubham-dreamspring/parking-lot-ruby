describe 'Parking Lot Model' do
  before(:each) do
    ParkingLot.reset
  end
  after(:each) { ParkingLot.reset }
  describe '#park' do
    it 'will give valid output' do
      car = Car.new(registration_no: 'UP12345678')

      car_details = ParkingLot.park(car)

      expect(car_details[:registration_no]).to be car.registration_no
      expect(car_details[:slot_id]).not_to be_nil
    end
  end

  describe '#unpark' do
    it 'will give invoice' do
      car = Car.new(registration_no: 'UP12345678')
      ParkingLot.park(car)

      invoice = ParkingLot.unpark(car)

      expect(invoice.registration_no).to eql car.registration_no
    end
  end

  describe '#parked_cars' do
    it 'will array of parked cars' do
      car1 = Car.new(registration_no: 'UP12345678')
      car2 = Car.new(registration_no: 'KS12345678')
      ParkingLot.park(car1)
      ParkingLot.park(car2)

      parked_cars = ParkingLot.parked_cars

      expect(parked_cars.find { |car| car[:registration_no] == car1.registration_no }).not_to be_nil
      expect(parked_cars.find { |car| car[:registration_no] == car2.registration_no }).not_to be_nil
    end
  end
end