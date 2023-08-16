# frozen_string_literal: true

require_relative '../app_constants'
require_relative '../utils/custom_orm'
require_relative '../services/invoice_amount_calculator'
require 'time'
# Class for Invoice Model
class Invoice < CustomOrm
  include ParkingLotConstants
  attr_reader :id, :entry_time, :exit_time, :registration_no, :amount

  def initialize(registration_no:, entry_time:, exit_time: nil, amount: nil, id: nil)
    @id = id || UUID.new.generate
    @registration_no = registration_no
    @entry_time = Integer(entry_time) rescue false ? entry_time : Time.parse(entry_time).to_i
    @exit_time = exit_time || Time.now.to_i
    @amount = amount || InvoiceAmountCalculator.execute(self)
  end

end
