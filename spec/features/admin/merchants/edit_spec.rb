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
      end
    end
  end
  # As an admin,
# When I visit a merchant's admin show page
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.