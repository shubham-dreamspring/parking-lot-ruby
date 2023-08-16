require_relative '../../models/Car'
describe Car do
  before(:each) do
    Car.reset
  end
  after(:each) do
    Car.reset
  end
  describe '#create' do
    context 'with invalid registration no' do
      it 'will throw error' do
        car = Car.new(registration_no: 'UPcd48')

        expect { car.create }.to raise_error InvalidRegNo
      end
    end

    it 'will save it to db' do
      registration_no = 'UP12345678'

      Car.new(registration_no: registration_no).create

      car = Car.find('registration_no', registration_no)
      expect(car).not_to be_nil
    end

    context 'with already parked car' do
      it 'will throw error' do
        registration_no = 'WW91827364'
        Car.new(registration_no: registration_no).create

        expect { Car.new(registration_no: registration_no).create }.to raise_error AlreadyExist
      end
    end
  end
  describe '#validate' do
    context 'with invalid registration no'
    it 'should start with two alphabets' do
      car = Car.new(registration_no: 'U7212356')

      expect { car.validate }.to raise_error InvalidRegNo
    end

    it 'should have length of 10' do
      car1 = Car.new(registration_no: 'UP72125')
      car2 = Car.new(registration_no: 'UP7212345dsfdfs')

      expect { car1.validate }.to raise_error InvalidRegNo
      expect { car2.validate }.to raise_error InvalidRegNo
    end

    it 'should not have special characters' do
      car1 = Car.new(registration_no: 'up3-3asd43')
      car2 = Car.new(registration_no: 'ka323*sd43')
      car3 = Car.new(registration_no: '23|323sd43')

      expect { car1.validate }.to raise_error InvalidRegNo
      expect { car2.validate }.to raise_error InvalidRegNo
      expect { car3.validate }.to raise_error InvalidRegNo
    end

    it 'should not have spaces' do
      car = Car.new(registration_no: 'ka323 sd43')

      expect { car.validate }.to raise_error InvalidRegNo
    end

  end
end

