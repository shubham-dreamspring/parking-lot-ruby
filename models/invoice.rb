# frozen_string_literal: true

require_relative '../app_constants'
require_relative '../utils/custom_orm'
require 'time'
# Class for Invoice Model
class Invoice < CustomOrm
  include ParkingLotConstants

  def initialize(registration_no:, entry_time:, exit_time: nil, amount: nil, id: nil)
    @registration_no = registration_no
    @entry_time = Integer(entry_time) rescue false  ? entry_time : Time.parse(entry_time).to_i
    @exit_time = exit_time || Time.now.to_i
    @amount = amount || Invoice.cal_amount(@exit_time - @entry_time)
    @id = id || UUID.new.generate
    create
  end

  def print_invoice
    puts ParkingLotConstants.INVOICE_PRINT_FORMAT(id: @id,
                                                 entry_time: @entry_time,
                                                 exit_time: @exit_time,
                                                 registration_no: @registration_no,
                                                 amount: @amount)
  end

  def self.cal_amount(duration)
    case duration
    when 0..10 then MINIMUM_PARKING_CHARGE
    when 10..30 then CHARGE_MORE_THAN_10_SEC
    when 30..60 then CHARGE_MORE_THAN_30_SEC
    else CHARGE_MORE_THAN_60_SEC
    end
  end
end
