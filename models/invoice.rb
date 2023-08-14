# frozen_string_literal: true

require_relative '../app_constants'
require_relative '../utils/custom_orm'
require 'time'
# Class for Invoice Model
class Invoice < CustomOrm
  include ParkingLotContants
  def initialize(registration_no, entry_time)
    @registration_no = registration_no
    @entry_time = Time.parse(entry_time).to_i
    @exit_time = Time.now.to_i
    @amount = Invoice.cal_amount(@exit_time - @entry_time)
    @invoice_id = UUID.new.generate
    create
  end

  def print_invoice
    puts ParkingLotContants.INVOICE_PRINT_FORMAT(invoice_id: @invoice_id,
                                                 entry_time: @entry_time,
                                                 exit_time: @exit_time,
                                                 registration_no: @registration_no,
                                                 amount: @amount)
  end

  def self.find_all
    invoices = super
    invoices.each do |invoice|
      puts ParkingLotContants.INVOICE_PRINT_FORMAT(invoice_id: invoice['invoice_id'],
                                                   entry_time: invoice['entry_time'],
                                                   exit_time: invoice['exit_time'],
                                                   registration_no: invoice['registration_no'],
                                                   amount: invoice['amount'])
    end
  end

  def self.find(invoice_id)
    invoice = super('invoice_id', invoice_id)
    raise ERR_INVOICE_NOT_FOUND if invoice.nil?

    puts ParkingLotContants.INVOICE_PRINT_FORMAT(invoice_id: invoice_id,
                                                 entry_time: invoice['entry_time'],
                                                 exit_time: invoice['exit_time'],
                                                 registration_no: invoice['registration_no'],
                                                 amount: invoice['amount'])
    invoice
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
