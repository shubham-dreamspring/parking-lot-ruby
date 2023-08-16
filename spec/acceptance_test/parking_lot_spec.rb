require_relative '../../services/invoice_printer'
describe 'Park a car when' do
  before(:each) do
    ParkingLot.reset
  end
  after(:each) do
    ParkingLot.reset
  end
  it 'registration number is invalid' do
    expect do
      system('MODE="test" ./app.rb -p UP12345')
    end.to output("#{ERR_INVALID_REGISTRATION_NO}\n").to_stdout_from_any_process
  end
  it 'registration number is valid ' do
    expect do
      system('MODE="test" ./app.rb -p UP12345678')
    end.to output("#{SUCCESS_PARK_CAR} 1\n").to_stdout_from_any_process
  end
  it 'car is already parked ' do
    ParkingLot.park(Car.new(registration_no: 'UP12345678'))

    expect do
      system('MODE="test" ./app.rb -p UP12345678')
    end.to output("#{ERR_CAR_ALREADY_PARKED}\n").to_stdout_from_any_process
  end
end

describe 'Unpark' do
  before(:all) do
    system('MODE="test" ./app.rb -p UP12345678')
  end
  after(:all) do
    ParkingLot.reset
  end
  it 'will not be succesful if car is not parked' do
    expect do
      system('MODE="test" ./app.rb -u KA12345678')
    end.to output("#{ERR_CAR_NOT_FOUND}\n").to_stdout_from_any_process
  end

  it 'will be successful' do
    expect do
      system('MODE="test" ./app.rb -u UP12345678')
    end.to output(Regexp.new(SUCCESS_UNPARK_CAR)).to_stdout_from_any_process
  end
end

describe 'Invoices' do
  before(:all) do
    ParkingLot.initialise_db
    ParkingLot.reset
  end
  after(:all) { ParkingLot.reset }
  before do
    allow(Time).to receive(:now).and_return(Time.at(123_456_789))
  end
  it 'get all' do
    car = Car.new(registration_no: 'UP12345678')
    ParkingLot.park(car)
    invoice = ParkingLot.unpark(car)

    expect do
      system('MODE="test" ./app.rb -i')
    end.to output(InvoicePrinter.execute(invoice)).to_stdout_from_any_process
  end
  it 'get by Id' do
    car = Car.new(registration_no: 'UP12345678')
    ParkingLot.park(car)
    invoice = ParkingLot.unpark(car)
    puts invoice.inspect

    system("MODE='test' ./app.rb -i #{invoice.id}")
    expect do
      system('MODE="test" ./app.rb -i')
    end.to output(InvoicePrinter.execute(invoice)).to_stdout_from_any_process
  end
end

describe 'parking lot' do
  before(:all) { system('MODE="test" ./app.rb -p UP12345678') }
  after(:all) { ParkingLot.reset }
  it 'show all cars' do
    expect do
      system('MODE="test" ./app.rb -c')
    end.to output("#{ParkingLotConstants.CARS_PRINT_FORMAT([{ registration_no: 'UP12345678',
                                                             slot_id: '1' }])}\n").to_stdout_from_any_process
  end
end
