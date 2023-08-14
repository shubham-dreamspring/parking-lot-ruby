# frozen_string_literal: true

require_relative '../utils/custom_orm'
require_relative '../utils/custom_errors'
require_relative '../app_constants'
require 'uuid'

# Class for Car Model
class Car < CustomOrm
  include ParkingLotContants
  include CustomErrors

  attr_reader :registration_no, :id

  def initialize(registration_no, id = nil)
    @registration_no = registration_no
    @id = id || setID
  end

  def self.find_by_registration_no(registration_no)
    cars = CustomOrm.read_db_file(db_name: DB_CARS)
    cars[registration_no]
  end

  def validate
    raise InvalidRegNo.new unless validate_registration_no?
    raise CarAlreadyParked.new if already_exist?
  end

  def already_exist?
    car = Car.find("registration_no", @registration_no)
    return false if car.nil?
    setID(car['id'])
    true
  end

  def validate_registration_no?
    Regexp.new(/[a-zA-Z]{2}[a-zA-Z0-9]{8}/).match?(@registration_no)
  end

  def setID(id = UUID.new.generate)
    @id = id
  end

  # def create
  #   validate
  #   setID
  #   CustomOrm.create({registration_no: @registration_no, id: @id})
  #   self
  # end
end
