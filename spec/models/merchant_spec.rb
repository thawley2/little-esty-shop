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
    
    it 'has the attribute of transaction_count' do
      expect(@merchant.top_5_customers.first.transaction_count).to eq(4)
      expect(@merchant.top_5_customers[1].transaction_count).to eq(3)
      expect(@merchant.top_5_customers[2].transaction_count).to eq(2)
      expect(@merchant.top_5_customers[3].transaction_count).to eq(2)
      expect(@merchant.top_5_customers[4].transaction_count).to eq(2)
    end

    it '#items_not_shipped' do
      expect(@merchant.items_not_shipped).to eq([@item1, @item2, @item2, @item3])
      expect(@merchant.items_not_shipped.first.invoice_id).to eq(@invoice2.id)
      expect(@merchant.items_not_shipped[1].invoice_id).to eq(@invoice3.id)
      expect(@merchant.items_not_shipped[2].invoice_id).to eq(@invoice4.id)
      expect(@merchant.items_not_shipped[-1].invoice_id).to eq(@invoice5.id)
    end
  end
end
