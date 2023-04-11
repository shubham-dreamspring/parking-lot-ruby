describe 'Park a car when' do
  after(:all) do
    FileUtils.remove_dir(TEST_DB_DIR)
  end
  it 'registration number is invalid' do
    expect do
      system('MODE="test" ruby app.rb -p UP12345')
    end.to output("\n#{ERR_INVALID_REGISTRATION_NO}\n").to_stdout_from_any_process
  end
  it 'registration number is valid ' do
    expect do
      system('MODE="test" ruby app.rb -p UP12345678')
    end.to output("\n#{SUCCESS_PARK_CAR} A10\n").to_stdout_from_any_process
  end
  it 'registration number is already parked ' do
    expect do
      system('MODE="test" ruby app.rb -p UP12345678')
    end.to output("\n#{ERR_CAR_ALREADY_PARKED} at A10\n").to_stdout_from_any_process
  end
  it 'no slot is available' do
    9.times { CustomOrm.delete_last_element }

    expect do
      system('MODE="test" ruby app.rb -p KJ12345678')
    end.to output("\n#{ERR_NO_EMPTY_SLOTS}\n").to_stdout_from_any_process
  end
end

describe 'Unpark a car when' do
  before(:all) do
    system('MODE="test" ruby app.rb -p UP12345678')
  end
  after(:all) do
    FileUtils.remove_dir(TEST_DB_DIR)
  end
  it 'given car is not parked' do
    expect do
      system('MODE="test" ruby app.rb -u KA12345678')
    end.to output("\n#{ERR_CAR_NOT_FOUND}\n").to_stdout_from_any_process
  end

  it 'given car is parked' do
    expect do
      system('MODE="test" ruby app.rb -u UP12345678')
    end.to output(Regexp.new(SUCCESS_UNPARK_CAR)).to_stdout_from_any_process
  end
end

describe 'Invoices' do
  before(:all) do
    CustomOrm.initialise_db TEST_DB_DIR
  end
  after(:all) { FileUtils.remove_dir(TEST_DB_DIR) }
  before do
    allow(Time).to receive(:now).and_return(Time.at(123_456_789))
  end
  it 'get all' do
    car = Car.new('UP12345678')
    Invoice.new(car)
    expect do
      system('MODE="test" ruby app.rb -i')
    end.to output("\n#{ParkingLotContants.INVOICE_PRINT_FORMAT(invoice_id: 'IN123456789', registration_no: 'UP12345678',
                                                               amount: Invoice.cal_amount(0), exit_time: 123_456_789,
                                                               entry_time: 123_456_789)}").to_stdout_from_any_process
  end
  it 'get by Id' do
    system('MODE="test" ruby app.rb -i IN123456789')
    expect do
      system('MODE="test" ruby app.rb -i')
    end.to output("\n#{ParkingLotContants.INVOICE_PRINT_FORMAT(invoice_id: 'IN123456789', registration_no: 'UP12345678',
                                                               amount: Invoice.cal_amount(0), exit_time: 123_456_789,
                                                               entry_time: 123_456_789)}").to_stdout_from_any_process
  end
end

describe 'parking lot' do
  before(:all) { system('MODE="test" ruby app.rb -p UP12345678') }
  after(:all) { FileUtils.remove_dir(TEST_DB_DIR) }
  it 'show all cars' do
    expect do
      system('MODE="test" ruby app.rb -c')
    end.to output("\n#{ParkingLotContants.CARS_PRINT_FORMAT([{ registration_no: 'UP12345678',
                                                               slot_id: 'A10' }])}\n").to_stdout_from_any_process
  end
end
