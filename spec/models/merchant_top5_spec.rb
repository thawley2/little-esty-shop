require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe '.top_five' do

    before do
      top_five_merchants  
    end

    it 'returns the top five merchants based on total revenue in descending order' do
      top_merchants = Merchant.top_five

      expect(top_merchants[0]).to eq(@merchant6)
      expect(top_merchants[1]).to eq(@merchant5)
      expect(top_merchants[2]).to eq(@merchant4)
      expect(top_merchants[3]).to eq(@merchant3)
      expect(top_merchants[4]).to eq(@merchant2)
      expect(top_merchants).to match_array([@merchant6, @merchant5, @merchant4, @merchant3, @merchant2])

      expect(Merchant.top_five.length).to eq(5)
    end
  end

  # Helper method to create invoice items and transactions with specified revenue for a merchant
  
end
