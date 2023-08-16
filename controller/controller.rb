# frozen_string_literal: true

require_relative '../models/car'
require_relative '../models/parking_lot'
require_relative '../models/invoice'
require_relative '../utils/custom_orm'
require_relative '../app_constants'
require_relative '../services/invoice_printer'
# Controller class
class Controller
  include ParkingLotConstants

  def initialize

    return if File.exist?(DB_DIR)

    CustomOrm.initialise_db
    Slot.reset
    Car.reset
  end

  def park(reg_no)
    car = Car.new(registration_no: reg_no)
    car_details = ParkingLot.park(car)
    puts "#{SUCCESS_PARK_CAR} #{car_details[:slot_id]}"
  rescue RuntimeError => e
    puts e
  end

  def unpark(reg_no)
    car = Car.new(registration_no: reg_no)
    invoice = ParkingLot.unpark(car)
    InvoicePrinter.execute(invoice)
    puts SUCCESS_UNPARK_CAR

  rescue RuntimeError => e
    puts e
  end

  def invoice(invoice_id)
    return Invoice.find_all.map { |invoice| InvoicePrinter.execute(invoice) } if invoice_id.nil?

    invoice = Invoice.find('id', invoice_id)
    raise RecordNotFound, 'Invoice is not there with this id' if invoice.nil?

    InvoicePrinter.execute(invoice)
  rescue RuntimeError => e
    puts e
  end

  def car
    cars = ParkingLot.parked_cars
    puts ParkingLotConstants.CARS_PRINT_FORMAT(cars)
  rescue RuntimeError => e
    puts e
  end
end
