class InvoicePrinter
  def self.execute(invoice)
    puts invoice.inspect
    puts ParkingLotConstants.INVOICE_PRINT_FORMAT(id: invoice.id,
                                                  entry_time: invoice.entry_time,
                                                  exit_time: invoice.exit_time,
                                                  registration_no: invoice.registration_no,
                                                  amount: invoice.amount)
  end
end