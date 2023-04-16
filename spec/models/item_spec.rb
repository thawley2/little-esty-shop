require 'rails_helper'

RSpec.describe Item, type: :model do

  before(:each) do
    merchant2_test_data
  end

  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }
  it { should define_enum_for(:status).with_values('enabled': 1, 'disabled': 0) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :unit_price }

  describe 'instance methods' do
    describe '#best_sell_date' do
      it 'returns the invoice date where the most transactions where successful for that item' do
        @invoice7.update(created_at: '23 Oct 2021')
      
        expect(@item11.best_sell_date).to eq(@invoice7.created_at)
      end
    end
  end
end
