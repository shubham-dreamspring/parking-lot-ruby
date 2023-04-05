require_relative "../constants.rb"
require_relative "../utils/orm.rb"

class Invoice
  include ParkingLotContants

  def initialize(car)
    @registration_no = car.registration_no
    @entry_time = car.entry_time
    @exit_time = Time.now.to_i
    @amount = cal_amount
    @invoice_id = "IN#{@exit_time}"
    push_to_db
  end

  def push_to_db
    invoice = { @invoice_id => {
      "registration_no" => @registration_no,
      "entry_time" => @entry_time,
      "exit_time" => @exit_time,
      "amount" => @amount,
    } }
    CustomOrm.write_db_file(db_name: DB_INVOICES, data: invoice)
  end

  def print_invoice
    puts ParkingLotContants.INVOICE_PRINT_FORMAT(invoice_id: @invoice_id, entry_time: @entry_time, exit_time: @exit_time, registration_no: @registration_no, amount: @amount)
  end

  def self.get_all
    invoices = CustomOrm.read_db_file(db_name: DB_INVOICES)
    invoices.each { |invoice_id, invoice| puts ParkingLotContants.INVOICE_PRINT_FORMAT(invoice_id: invoice_id, entry_time: invoice["entry_time"], exit_time: invoice["exit_time"], registration_no: invoice["registration_no"], amount: invoice["amount"]) }
  end

  def self.get_by_id(invoice_id)
    invoices = CustomOrm.read_db_file(db_name: DB_INVOICES)
    invoice = invoices[invoice_id]
    if invoice.nil?
      puts ERR_INVOICE_NOT_FOUND
      return
    end
    puts ParkingLotContants.INVOICE_PRINT_FORMAT(invoice_id: invoice_id, entry_time: invoice["entry_time"], exit_time: invoice["exit_time"], registration_no: invoice["registration_no"], amount: invoice["amount"])
  end

  private def cal_amount
    case @exit_time - @entry_time
    when 0..10 then MINIMUM_PARKING_CHARGE
    when 10..30 then CHARGE_MORE_THAN_10_SEC
    when 30..60 then CHARGE_MORE_THAN_30_SEC
    else CHARGE_MORE_THAN_60_SEC
    end
  end
end
