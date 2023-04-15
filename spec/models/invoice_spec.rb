require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:all) do
    test_data
  end
  it { should belong_to(:customer) }
  it { should have_many(:invoice_items) }
  it { should have_many(:items).through(:invoice_items) }
  it { should have_many(:transactions) }

  it { should define_enum_for(:status).with_values('in progress': 0, 'completed': 1, 'cancelled': 2) }

  it 'checks unshipped items' do
    expect(Invoice.incomplete_invoices).to match_array([@invoice2, @invoice3, @invoice4, @invoice5])
  end

  xit '#incomplete invoices attribute of invoice_creation' do
    expect(Invoice.incomplete_invoices.first.created_at.strftime("%A %B %d %Y")).to eq(@invoice2.created_at.strftime("%A %B %d %Y"))
  end

  describe '#format_date' do
    it 'returns the date of the invoice in yyyy/mm/dd format' do
      @invoice1.created_at = "Mon, 27 Feb 2023 22:51:42 UTC +00:00"
      expect(@invoice1.format_date).to eq("Monday, February 27, 2023")
    end
  end
end
