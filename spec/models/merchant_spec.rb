require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    test_data
  end
  it { should have_many(:items) }

  describe 'instance methods' do
    it '#top_5_customers' do
      expect(@merchant.top_5_customers).to eq([@customer6, @customer2, @customer3, @customer4, @customer5])
    end
  end
end
