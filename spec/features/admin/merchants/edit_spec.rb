require 'rails_helper'

RSpec.describe 'Edit Merchant Show Page' do
  let!(:merchant) {create(:merchant, name: 'Steve')}

  describe 'On the edit merchant show page' do
    it 'I am taken to a page to edit this merchant and I see a form filled in with the existing merchant attribute information' do
      visit edit_admin_merchant_path(merchant)
      
      fill_in 'Name', with: "Andrew"
      click_button 'Update Merchant'
    
      expect(current_path).to eq(admin_merchant_path(merchant))
      expect(page).to have_content("Andrew")
      expect(page).to have_content("Andrew was successfully updated.")
      
    end
  end
end
