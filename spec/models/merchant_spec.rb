require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    test_data
  end
  it { should have_many(:items) }
  it { should have_many(:invoice_items).through(:items)}
  it { should have_many(:invoices).through(:items)}
  it { should have_many(:customers).through(:invoices)}

  describe 'instance methods' do
    it '#top_5_customers' do
      expect(@merchant.top_5_customers).to eq([@customer6, @customer2, @customer3, @customer4, @customer5])
    end
    
    it '#top_5_customers has the attribute of transaction_count' do
      expect(@merchant.top_5_customers.first.transaction_count).to eq(4)
      expect(@merchant.top_5_customers[1].transaction_count).to eq(3)
      expect(@merchant.top_5_customers[2].transaction_count).to eq(2)
      expect(@merchant.top_5_customers[3].transaction_count).to eq(2)
      expect(@merchant.top_5_customers[4].transaction_count).to eq(2)
    end

    it '#items_not_shipped' do
      expect(@merchant.items_not_shipped).to match_array([@item1, @item2])
      expect(@merchant.items_not_shipped.first.invoice_id).to eq(@invoice2.id)
      expect(@merchant.items_not_shipped[1].invoice_id).to eq(@invoice3.id)
    end

    it '#items_not_shipped has the attribute of invoice_creation' do
      expect(@merchant.items_not_shipped.first.invoice_creation.strftime("%A %B %d %Y")).to eq(@invoice2.created_at.strftime("%A %B %d %Y"))
      expect(@merchant.items_not_shipped[1].invoice_creation.strftime("%A %B %d %Y")).to eq(@invoice3.created_at.strftime("%A %B %d %Y"))
    end
  end
end
