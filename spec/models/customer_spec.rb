require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:invoices) }

  before(:each) do
    test_data
  end

  describe '#top_five_customers' do
    it 'returns the top five customers with the most successful transactions in descending order' do
      expect(Customer.top_five_customers).to match_array([@customer6, @customer2, @customer3, @customer4,@customer5 ])
      end

    it '#full_name, returns the full name of the customer' do
      @customer1.update(first_name: 'Kat', last_name: 'Bobby')

      expect(@customer1.full_name).to eq('Kat Bobby')
    end
  end
end