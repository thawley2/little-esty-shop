require 'rails_helper'

RSpec.describe 'Admin Merchant Show Page' do
  let!(:merchant) {create(:merchant, name: 'Steve')}

  describe 'On the admin merchant show page' do
    it 'User Story 25 I see the name of the merchant' do
      visit admin_merchant_path(merchant)

      expect(current_path).to eq(admin_merchant_path(merchant))
      expect(page).to have_content(merchant.name)
    end

    it "User Story 26 I see a link to update the merchant's information" do
      visit admin_merchant_path(merchant)

      click_link("Update #{merchant.name}")
   
      expect(current_path).to eq(edit_admin_merchant_path(merchant))
    end
  end
end
