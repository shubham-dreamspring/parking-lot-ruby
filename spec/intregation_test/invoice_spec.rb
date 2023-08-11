require_relative '../../models/Invoice'
require_relative '../../models/Car'

require_relative '../../utils/custom_orm'

describe Invoice do
  before(:all) do
    CustomOrm.initialise_db
  end
  before do
    allow(Time).to receive(:now).and_return(Time.at(123_456_789))
  end
  after(:all) do
    CustomOrm.delete_element_by_key(db_name: DB_INVOICES, key: 'IN123456789')
  end
  it 'create' do
    car = Car.new('UP12345678')
    Invoice.new(car)
    invoices = CustomOrm.read_db_file(db_name: DB_INVOICES)
    expect(invoices.size).to be 1
    expect(invoices['IN123456789']).not_to be_nil
  end
  it 'read all' do
    expect(Invoice.find_all.size).to be 1
  end
  it 'read by id' do
    inv = Invoice.find_by_id('IN123456789')
    expect(inv['registration_no']).to eq 'UP12345678'
  end

  it 'amount' do
    expect(Invoice.cal_amount(200)).to be 500
    expect(Invoice.cal_amount(0)).to be 100
    expect(Invoice.cal_amount(30)).to be 200
    expect(Invoice.cal_amount(40)).to be 300
  end
end
