require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe '.top_five' do
    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
    let!(:merchant3) { create(:merchant) }
    let!(:merchant4) { create(:merchant) }
    let!(:merchant5) { create(:merchant) }
    let!(:merchant6) { create(:merchant) }

    before do
      # Create invoice items and transactions with different revenue amounts for each merchant
      create_invoice_items_and_transactions(merchant1, 1000)
      create_invoice_items_and_transactions(merchant2, 2000)
      create_invoice_items_and_transactions(merchant3, 3000)
      create_invoice_items_and_transactions(merchant4, 4000)
      create_invoice_items_and_transactions(merchant5, 5000)
      create_invoice_items_and_transactions(merchant6, 6000)
    end

    it 'returns the top five merchants based on total revenue in descending order' do
      top_merchants = Merchant.top_five

      expect(top_merchants.count).to eq(5)
      expect(top_merchants[0]).to eq(merchant6)
      expect(top_merchants[1]).to eq(merchant5)
      expect(top_merchants[2]).to eq(merchant4)
      expect(top_merchants[3]).to eq(merchant3)
      expect(top_merchants[4]).to eq(merchant2)
    end
  end

  # Helper method to create invoice items and transactions with specified revenue for a merchant
  def create_invoice_items_and_transactions(merchant, revenue)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice)
    create(:invoice_item, item: item, invoice: invoice, quantity: 1, unit_price: revenue)
    create(:transaction, result: 'success', invoice: invoice)
  end
end
