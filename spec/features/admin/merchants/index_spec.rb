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
          click_button "Enable Merchant"
          expect(current_path).to eq(admin_merchants_path)
        end

        expect(page).to have_content("Steve is Enabled")
        
        within ".enabled_merchants" do
          within ".merchant#{merchant2.id}" do
            expect(page).to have_button("Disable Merchant")
          end

          within ".merchant#{merchant1.id}" do
            click_button "Disable Merchant"
            expect(current_path).to eq(admin_merchants_path)
          end
        end

        expect(page).to have_content("Steve is Disabled")
      end
    end
  end
end