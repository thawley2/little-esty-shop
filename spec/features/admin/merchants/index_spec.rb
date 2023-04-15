require 'rails_helper'

RSpec.describe 'Merchant Index' do
  describe 'As an admin' do
    let!(:merchant1) {Merchant.create!(name:'Steve', enabled: false)}
    let!(:merchant2) {Merchant.create!(name:'Fred', enabled: true)}
  

    describe 'When I visit the admin merchants index' do
      it 'I see the name of each merchant in the system' do
        visit admin_merchants_path

        expect(page).to have_content('Merchants Index')

        within '.merchant_names' do
          expect(page).to have_content(merchant1.name)
          expect(page).to have_content(merchant2.name)
        end
      end
    end

      it 'I click the name of a merchant' do
        visit admin_merchants_path

        click_link(merchant1.name)
        expect(current_path).to eq(admin_merchant_path(merchant1))
      end

    describe 'When I visit the admin merchants index' do
      it 'I see a button to disable or enable that merchant next to each merchant name' do
        visit admin_merchants_path
        save_and_open_page
      
        within ".merchant#{merchant1.id}" do
          click_button "Enable Merchant"
        end
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_content("Steve is Enabled")

        within ".merchant#{merchant2.id}" do
          click_button "Disable Merchant"
        end
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_content("Fred is Disabled")
      
        within ".merchant#{merchant1.id}" do
          click_button "Disable Merchant"
        end

        within ".merchant#{merchant2.id}" do
          click_button "Enable Merchant"
        end
      end
    end
#     As an admin,
# When I visit the admin merchants index
# Then next to each merchant name I see a button to disable or enable that merchant.
# When I click this button
# Then I am redirected back to the admin merchants index
# And I see that the merchant's status has changed
  end
end