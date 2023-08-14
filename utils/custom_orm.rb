# frozen_string_literal: true

require_relative '../app_constants'
require_relative 'adapter'
require 'linguistics'

class CustomOrm
  include ParkingLotContants
  Linguistics.use('en')

  def self.doc
    name.to_s.downcase.en.plural + DB_FILE_FORMAT
  end

  def doc
    self.class.name.to_s.downcase.en.plural + DB_FILE_FORMAT
  end

  def validate
    true
  end

  def self.initialise_db(db_dir = DB_DIR)
    Dir.mkdir(db_dir) unless File.exist?(db_dir)
    return unless Dir.empty?(db_dir.to_s)

    Adapter.write_file("#{db_dir}/#{DB_CARS}", [])
    Adapter.write_file("#{db_dir}/#{DB_SLOTS}", [])
    Adapter.write_file("#{db_dir}/#{DB_INVOICES}", [])

  end

  def self.find_all(sort_property = nil, limit = nil)
    Adapter.read("#{DB_DIR}/#{doc}") do |data|
      data = data.sort { |x, y| y[sort_property] - x[sort_property] } if sort_property
      data = data.slice(0, 3) if limit
      data
    end
  end

  def self.delete(property_name = "id", property_value)
    return Adapter.read_write("#{DB_DIR}/#{doc}") { |data| data.filter { |item| item[property_name] != property_value } }
  end

  def self.reset(data = [])
    Adapter.write_file("#{DB_DIR}/#{doc}", data)
  end

  def self.find(property_name, property_value)
    Adapter.read("#{DB_DIR}/#{doc}") do |data|
      data.find { |c| c[property_name] == property_value }
    end
  end

  def create
    validate
    instance = {}
    instance_variables.map do |attribute|
      instance[attribute.to_s[1..-1]] = instance_variable_get(attribute)
    end
    instance[:timestamp] = Time.now if instance.has_key? :timestamp

    Adapter.read_write("#{DB_DIR}/#{doc}") do |data|
      data.push(instance)
    end
    instance
  end

  def update(update_by = 'id')
    instance = {}
    instance_variables.map do |attribute|
      instance[attribute.to_s[1..-1]] = instance_variable_get(attribute)
    end
    Adapter.read_write("#{DB_DIR}/#{doc}") do |data|
      index = data.index { |ele| instance[update_by] == ele[update_by] }
      data[index] = instance
      data
    end
    instance
  end
end
