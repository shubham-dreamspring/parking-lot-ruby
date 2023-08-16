require_relative '../../models/Invoice'
require_relative '../../models/Car'

require_relative '../../utils/custom_orm'

describe InvoiceAmountCalculator do

  describe '#execute' do

    it 'will calculate amount' do
      invoice1 = Invoice.new registration_no: 'UP123456', entry_time: 0, exit_time: 200
      invoice2 = Invoice.new registration_no: 'UP123456', entry_time: 0, exit_time: 0
      invoice3 = Invoice.new registration_no: 'UP123456', entry_time: 0, exit_time: 30
      invoice4 = Invoice.new registration_no: 'UP123456', entry_time: 0, exit_time: 40

      expect(InvoiceAmountCalculator.execute(invoice1)).to be 500
      expect(InvoiceAmountCalculator.execute(invoice2)).to be 100
      expect(InvoiceAmountCalculator.execute(invoice3)).to be 200
      expect(InvoiceAmountCalculator.execute(invoice4)).to be 300
    end
  end
end
