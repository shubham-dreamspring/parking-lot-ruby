# frozen_string_literal: true

require_relative '../../utils/orm'
require 'fileutils'


RSpec.describe CustomOrm do
  it 'initialises the database' do
    CustomOrm.initialise_db
    expect(File.exist?(TEST_DB_DIR)).to be_truthy
    expect(File.exist?("#{TEST_DB_DIR}/#{DB_CARS}")).to be_truthy
    expect(File.exist?("#{TEST_DB_DIR}/#{DB_EMPTY_SLOTS}")).to be_truthy
    expect(File.exist?("#{TEST_DB_DIR}/#{DB_INVOICES}")).to be_truthy
  end
  it 'read the db' do
    expect(CustomOrm.read_db_file(
                                  db_name: DB_EMPTY_SLOTS)).to eql CustomOrm.intilise_empty_slots
  end
  it 'write the items' do
    data = {
      'UP12345678' => { 'slot_id' => 'A10', 'entry_time' => 1_680_763_857 }
    }
    CustomOrm.write_db_file(db_name: DB_CARS, data: data)

    expect(CustomOrm.read_db_file(db_name: DB_CARS)).to eql data
  end
  it 'delete the item with key' do
    CustomOrm.delete_element_by_key(db_name: DB_CARS, key: 'UP12345678')
    expect(CustomOrm.read_db_file(db_name: DB_CARS)).to eql({})
  end

  it 'delete the last item' do
    CustomOrm.delete_element_by_key(db_name: DB_CARS,
                                                 key: 'UP12345678')
    expect(CustomOrm.read_db_file(db_name: DB_CARS)).to eql({})
  end
end
