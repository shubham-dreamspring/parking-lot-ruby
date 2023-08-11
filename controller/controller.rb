# frozen_string_literal: true

require_relative '../models/car'
require_relative '../models/parking_lot'
require_relative '../models/invoice'
require_relative '../utils/custom_orm'
require_relative '../app_constants'
# Controller class
class Controller
  include ParkingLotContants

  def initialize

    return if File.exist?(DB_DIR)

    CustomOrm.initialise_db
    Slot.reset
    Car.reset
  end

  def park(reg_no)
    car = Car.new(reg_no)
    car_details = ParkingLot.park(car)
    puts "#{SUCCESS_PARK_CAR} #{car_details[:slot_id]}"
  rescue RuntimeError => e
    puts e
  end

  def unpark(reg_no)
    car = Car.new(reg_no)
    invoice = ParkingLot.unpark(car)
    invoice.print_invoice
    puts SUCCESS_UNPARK_CAR

  rescue RuntimeError => e
    puts e
  end

  def invoice(invoice_id)
    return Invoice.find_all if invoice_id.nil?

    Invoice.find(invoice_id)
  rescue RuntimeError => e
    puts e
  end

  def car
    car = ParkingLot.parked_cars
    puts ParkingLotContants.CARS_PRINT_FORMAT(car)
  rescue RuntimeError => e
    puts e
  end
end
