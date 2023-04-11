# frozen_string_literal: true

require 'json'
require_relative '../app_constants'

# Class for Invoice Model
class CustomOrm
  include ParkingLotContants

  def self.initialise_db(db_dir = DB_DIR)
    Dir.mkdir(db_dir) unless File.exist?(db_dir)
    return unless Dir.empty?(db_dir.to_s)

    File.open("#{db_dir}/#{DB_CARS}", 'w') do |f|
      f.write(JSON.generate({}))
    end

    File.open("#{db_dir}/#{DB_EMPTY_SLOTS}", 'w') do |f|
      a = intilise_empty_slots
      f.write(JSON.generate(a))
    end

    File.open("#{db_dir}/#{DB_INVOICES}", 'w') { |f| f.write(JSON.generate({})) }
  end

  def self.read_db_file(db_dir = DB_DIR, db_name:)
    File.open("#{db_dir}/#{db_name}", 'r') do |f|
      return JSON.load(f)
    end
  end

  def self.write_db_file(db_dir = DB_DIR, db_name:, data:)
    file_data = read_db_file(db_name: db_name)
    if db_name == DB_EMPTY_SLOTS
      file_data << data
    else
      file_data.merge!(data)
    end
    File.open("#{db_dir}/#{db_name}", 'w') do |f|
      f.write(JSON.dump(file_data))
    end
  end

  def self.delete_last_element(db_dir = DB_DIR, db_name = DB_EMPTY_SLOTS)
    file_data = read_db_file(db_name: db_name)
    file_data.pop
    File.open("#{db_dir}/#{db_name}", 'w') do |f|
      f.write(JSON.dump(file_data))
    end
  end

  def self.delete_element_by_key(db_dir = DB_DIR, db_name:, key:)
    file_data = read_db_file(db_name: db_name)
    file_data.delete(key)
    File.open("#{db_dir}/#{db_name}", 'w') do |f|
      f.write(JSON.dump(file_data))
    end
  end

  def self.intilise_empty_slots
    a = []
    (1..TOTAL_CAPACITY_OF_PARKING_LOT).each { |n| a << "A#{n}" }
    a
  end
end
