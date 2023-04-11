require_relative '../../models/car'
describe Car do
  it 'has valid registration number' do
    expect { Car.validate_registration_no('12345') }.to raise_error RuntimeError
    expect { Car.validate_registration_no('1234567890') }.to raise_error RuntimeError
    expect { Car.validate_registration_no('UP123456') }.to raise_error RuntimeError
    expect { Car.validate_registration_no('UP12  3456') }.to raise_error RuntimeError
    expect { Car.validate_registration_no('UP12--3456') }.to raise_error RuntimeError
    expect { Car.validate_registration_no('U11234563') }.to raise_error RuntimeError
    expect { Car.validate_registration_no('UP1234563') }.to raise_error RuntimeError
  end
end
