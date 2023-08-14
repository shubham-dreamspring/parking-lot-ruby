# frozen_string_literal: true

require_relative '../utils/custom_orm'
require_relative '../utils/custom_errors'
require_relative '../app_constants'
require 'uuid'

# Class for Car Model
class Car < CustomOrm
  include ParkingLotConstants
  include CustomErrors

  attr_reader :registration_no, :id

  def initialize(registration_no:, id: nil)
    @registration_no = registration_no
    @id = id || set_id
  end

  def validate
    raise CarAlreadyParked if already_exist?
    raise InvalidRegNo unless validate_registration_no?

    true
  end

  def already_exist?
    car = Car.find("registration_no", @registration_no)
    return false if car.nil?
    true
  end

  def validate_registration_no?
    Regexp.new(/^[a-zA-Z]{2}[a-zA-Z0-9]{8}$/).match?(@registration_no)
  end

  private

  def set_id(id = UUID.new.generate)
    @id = id
  end

end
