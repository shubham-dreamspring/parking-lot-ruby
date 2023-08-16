require_relative '../app_constants'

class InvoiceAmountCalculator
  include ParkingLotConstants

  def self.execute(invoice)
    duration = invoice.exit_time - invoice.entry_time
    case duration
    when 0..10 then MINIMUM_PARKING_CHARGE
    when 10..30 then CHARGE_MORE_THAN_10_SEC
    when 30..60 then CHARGE_MORE_THAN_30_SEC
    else CHARGE_MORE_THAN_60_SEC
    end
  end
end