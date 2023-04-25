require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it { should belong_to(:item) }
  it { should belong_to(:invoice) }

  it { should define_enum_for(:status).with_values(pending: 0, packaged: 1, shipped: 2) }

  describe 'instance methods' do
    describe '#applied_discount' do
      it 'returns the discount object that was applied to the invoice item' do
        merchant3_test_data
        @discount2 = create(:bulk_discount, percent_discount: 0.20, quantity_threshold: 10, merchant: @merchant2)
        @discount3 = create(:bulk_discount, percent_discount: 0.15, quantity_threshold: 9, merchant: @merchant2)
        expect(@init1.applied_discount).to eq(@discount2)
      end
    end
  end
end
