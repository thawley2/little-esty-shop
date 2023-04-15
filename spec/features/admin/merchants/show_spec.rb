require 'rails_helper'

RSpec.describe 'Admin Merchant Show Page' do
  describe 'On the admin merchant show page' do
    let!(:merchant) {create(:merchant, name: 'Steve')}
    it 'I see the name of the merchant' do
      visit admin_merchant_path(merchant)

      expect(current_path).to eq(admin_merchant_path(merchant))
      expect(page).to have_content(merchant.name)
    end
  end
end