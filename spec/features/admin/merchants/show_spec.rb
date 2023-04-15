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
# As an admin,
# When I visit a merchant's admin show page
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.