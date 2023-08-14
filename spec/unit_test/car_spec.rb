require_relative '../../models/Car'
describe Car do
  context 'on create' do
    before(:each) do
      Car.reset
    end
    after(:each) do
      Car.reset
    end
    it 'will throw error if it is invalid registration no' do
      car = Car.new('UPcd48')

      expect { car.create }.to raise_error InvalidInput
    end

    it 'will save' do
      registration_no = 'UP12345678'

      Car.new(registration_no).create

      expect(Car.find('registration_no', registration_no)).not_to be_nil
    end

    it 'will throw error if car is already existed' do
      registration_no = 'WW91827364'
      Car.new(registration_no).create

      expect { Car.new(registration_no).create }.to raise_error AlreadyExist
    end
  end
  context 'on validate' do
    #context for registration No validation
    it 'start with two alphabets' do
      expect(Car.new('UP72123456').validate).to be_truthy
      expect(Car.new('UP72asdfgh').validate).to be_truthy
      expect(Car.new('Up323asd43').validate).to be_truthy
    end

    it 'should have length of 10' do
      expect(Car.new('UP12345678').validate).to be_truthy
    end

    it 'should not permit special characters' do
      expect { Car.new('up3-3asd43').validate }.to raise_error RuntimeError
      expect { Car.new('ka323*sd43').validate }.to raise_error RuntimeError
      expect { Car.new('23|323sd43').validate }.to raise_error RuntimeError
    end

    it 'should not permit spaces' do
      expect { Car.new('ka323 sd43').validate }.to raise_error RuntimeError
    end

    it 'should not have length more or less than 10' do
      expect { Car.new('UP72asdfgh32324').validate }.to raise_error RuntimeError
      expect { Car.new('72123456').validate }.to raise_error RuntimeError
    end
  end
end

