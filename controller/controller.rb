# frozen_string_literal: true

require_relative '../models/car'
require_relative '../models/parking_lot'
require_relative '../models/invoice'
require_relative '../utils/orm'

# Controller class
class Controller
  def initialize
    CustomOrm.initialise_db
  end

  def park(reg_no)
    car = Car.new(reg_no)
    ParkingLot.new.park(car)
  rescue RuntimeError => e
    puts e
  end

  def unpark(reg_no)
    car = Car.new(reg_no)
    ParkingLot.new.unpark(car)
  rescue RuntimeError => e
    puts e
  end

  def invoice(invoice_id)
    return Invoice.find_all if invoice_id.nil?

    Invoice.find_by_id(invoice_id)
  rescue RuntimeError => e
    puts e
  end

  def car
    Car.find_all
  rescue RuntimeError => e
    puts e
  end
end
