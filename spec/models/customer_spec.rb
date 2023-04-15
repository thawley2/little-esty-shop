require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:invoices) }

before(:all) do
  test_data
end

describe '#top_five_customers' do
  it 'returns the top five customers with the most successful transactions in descending order' do
    expect(Customer.top_five_customers).to eq([@customer6, @customer2, @customer3, @customer4,@customer5 ])
    end
  end
end