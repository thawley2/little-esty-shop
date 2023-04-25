require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:each) do
    test_data
  end
  
  it { should belong_to(:customer) }
  it { should have_many(:invoice_items) }
  it { should have_many(:items).through(:invoice_items) }
  it { should have_many(:transactions) }

  it { should define_enum_for(:status).with_values('in progress': 0, 'completed': 1, 'cancelled': 2) }

  it 'returns #incomplete_invoices' do
    expect(Invoice.incomplete_invoices).to match_array([@invoice2, @invoice3, @invoice4, @invoice5])
    expect(Invoice.incomplete_invoices.none?{|inv| inv.status == 2})
  end

  describe '#format_date' do
    it 'returns the date of the invoice in yyyy/mm/dd format' do
      @invoice1.created_at = "Mon, 27 Feb 2023 22:51:42 UTC +00:00"
      expect(@invoice1.format_date).to eq("Monday, February 27, 2023")
    end
  end

  describe '#total_revenue' do
    it 'returns the total revenue as an integer for all invoice_items linked to an invoice' do
      @inv_itm1.update(unit_price: 1500, quantity: 5)
      @inv_itm2.update(unit_price: 2500, quantity: 17)
      expect(@invoice1.total_revenue).to eq(7500)
    end
  end

  describe '#inv_total_rev_discs' do
    it 'returns total revenue from an invoice when a merchant has bulk discounts' do
      merchant3_test_data
      expect(@invoice7.inv_total_rev_discs(@merchant2.id)).to eq(16750)
      expect(@invoice7.inv_total_rev_discs(@merchant3.id)).to eq(0)
    end

    it 'if an invoice item qualifies for two discounts it applies the highest percentage' do
      merchant3_test_data
      @discount2 = create(:bulk_discount, percent_discount: 0.20, quantity_threshold: 10, merchant: @merchant2)
      expect(@invoice7.inv_total_rev_discs(@merchant2.id)).to eq(14000)
    end
  end

  describe '#total_revenue_merchant_discount' do
    it 'returns the total revenue with discounts applied to the whole invoice only to the merchant invoice items with bulk discounts' do
      merchant3_test_data
      @discount2 = create(:bulk_discount, percent_discount: 0.20, quantity_threshold: 10, merchant: @merchant2)
      @discount3 = create(:bulk_discount, percent_discount: 0.20, quantity_threshold: 30, merchant: @merchant3)
      
      expect(@invoice7.total_revenue_merchant_discount).to eq(27125)
    end
  end

  describe '#total_revenue_merchant_no_discount' do
    it 'returns the total revenue of merchants that do not' do
      merchant3_test_data
      @discount2 = create(:bulk_discount, percent_discount: 0.20, quantity_threshold: 10, merchant: @merchant2)

      expect(@invoice7.total_revenue_merchant_no_discount).to eq(13125)
    end

    it '#total_total_total' do
      merchant3_test_data
      @discount2 = create(:bulk_discount, percent_discount: 0.20, quantity_threshold: 10, merchant: @merchant2)

      expect(@invoice7.total_discount_revenue).to eq(27125)
    end
  end
end
