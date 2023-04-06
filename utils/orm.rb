# frozen_string_literal: true

require 'json'
require_relative '../constants'

# Class for Invoice Model
class CustomOrm
  include ParkingLotContants

  def self.initialise_db
    Dir.mkdir(DB_DIR.to_s) unless File.exist?(DB_DIR.to_s)
    File.open("#{DB_DIR}/#{DB_CARS}", 'w') do |f|
      f.write(JSON.generate({}))
    end
    File.open("#{DB_DIR}/#{DB_EMPTY_SLOTS}", 'w') do |f|
      a = []
      (1..TOTAL_CAPACITY_OF_PARKING_LOT).each { |n| a << "A#{n}" }
      f.write(JSON.generate(a))
    end
    File.open("#{DB_DIR}/#{DB_INVOICES}", 'w') { |f| f.write(JSON.generate({})) }
  end

  def self.read_db_file(db_name:)
    File.open("#{DB_DIR}/#{db_name}", 'r') do |f|
      return JSON.load(f)
    end
  end

  def self.write_db_file(db_name:, data:)
    file_data = read_db_file(db_name: db_name)
    if db_name == DB_EMPTY_SLOTS
      file_data << data
    else
      file_data.merge!(data)
    end
    File.open("#{DB_DIR}/#{db_name}", 'w') do |f|
      f.write(JSON.dump(file_data))
    end
  end

  def self.delete_last_element(db_name = DB_EMPTY_SLOTS)
    file_data = read_db_file(db_name: db_name)
    file_data.pop
    File.open("#{DB_DIR}/#{db_name}", 'w') do |f|
      f.write(JSON.dump(file_data))
    end
  end

  def self.delete_element_by_key(db_name:, key:)
    file_data = read_db_file(db_name: db_name)
    file_data.delete(key)
    File.open("#{DB_DIR}/#{db_name}", 'w') do |f|
      f.write(JSON.dump(file_data))
    end
  end
end
