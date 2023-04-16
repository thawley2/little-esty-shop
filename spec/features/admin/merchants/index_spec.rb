require 'rails_helper'

RSpec.describe 'Merchant Index' do
  describe 'As an admin' do
    let!(:merchant1) {Merchant.create!(name:'Steve')}
    let!(:merchant2) {Merchant.create!(name:'Fred')}
  

    describe 'When I visit the admin merchants index' do
      it 'I see the name of each merchant in the system' do
        visit admin_merchants_path

        expect(page).to have_content('Merchants Index')

        within '.merchant_names' do
          expect(page).to have_content(merchant1.name)
          expect(page).to have_content(merchant2.name)
        end
      end

      it 'I click the name of a merchant' do
        visit admin_merchants_path

        click_link(merchant1.name)
        expect(current_path).to eq(admin_merchant_path(merchant1))
      end
    end
  end
end