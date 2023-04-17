require 'rails_helper'

RSpec.describe 'Merchant Index' do
  describe 'As an admin' do
    let!(:merchant1) {Merchant.create!(name:'Steve', enabled: false)}
    let!(:merchant2) {Merchant.create!(name:'Fred', enabled: true)}
  

    describe 'When I visit the admin merchants index' do
      it 'I see the name of each merchant in the system' do
        visit admin_merchants_path

        expect(page).to have_content('Merchants Index')

        expect(page).to have_content(merchant1.name)
        expect(page).to have_content(merchant2.name)
      end

      it 'I click the name of a merchant' do
        visit admin_merchants_path

        click_link(merchant1.name)
        expect(current_path).to eq(admin_merchant_path(merchant1))
      end
      
      it 'I see sections for enabled/disabled merchants with enable/disable buttons next to their names' do
        visit admin_merchants_path
      
        within ".disabled_merchants .merchant#{merchant1.id}" do
          click_button "Enable #{merchant1.name}"
          expect(current_path).to eq(admin_merchants_path)
        end

        expect(page).to have_content("Steve is Enabled")
        
        within ".enabled_merchants" do
          within ".merchant#{merchant2.id}" do
            expect(page).to have_button("Disable #{merchant2.name}")
          end

          within ".merchant#{merchant1.id}" do
            click_button "Disable #{merchant1.name}"
            expect(current_path).to eq(admin_merchants_path)
          end
        end
        expect(page).to have_content("Steve is Disabled")
      end

      it 'I see a link to create a new merchant with a default status of disabled' do
        visit admin_merchants_path
        
        expect(page).not_to have_content('Marchand')
  
        click_link 'Create New Merchant'
        expect(current_path).to eq(new_admin_merchant_path)
  
        fill_in 'Name', with: 'Marchand'
        click_button 'Create Merchant'
  
        expect(current_path).to eq(admin_merchants_path)
  
        within '.disabled_merchants' do
          expect(page).to have_content('Marchand')
        end
  
        expect(page).to have_content('Marchand was successfully created')
      end
    end
  end
end
# As an admin,
# When I visit the admin merchants index
# I see a link to create a new merchant.
# When I click on the link,
# I am taken to a form that allows me to add merchant information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the admin merchants index page
# And I see the merchant I just created displayed
# And I see my merchant was created with a default status of disabled.