#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'controller/controller'

controller = Controller.new
OptionParser.new do |opts|
  opts.banner = "===========================================
        WELCOME TO PARKING LOT
==========================================="
  opts.on('-p', '--park REGISTRATION_NO', ' Park your car with registration no') do |reg_no|
    controller.park reg_no
  end
  opts.on('-u', '--unpark REGISTRATION_NO', ' Unpark your car with registration no') do |reg_no|
    controller.unpark reg_no
  end
  opts.on('-i', '--invoice [INVOICE_ID]', ' Get Invoices') do |ext|
    controller.invoice(ext)
  end
  opts.on('-c', '--cars', ' Get all cars in parking lot') do
    controller.car
  end
end.parse!
