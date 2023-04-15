require 'rails_helper'

RSpec.describe 'Merchant Index' do
  describe 'As an admin' do
    let!(:merchant1) {Merchant.create!(name:'Steve')}
    let!(:merchant2) {Merchant.create!(name:'Fred')}
  

    describe 'When I visit the admin merchants index' do
      it 'I see the name of each merchant in the system' do
        visit admin_merchants_path
        save_and_open_page

        expect(page).to have_content('Merchants Index')
        within '.merchant_names' do
          expect(page).to have_content(merchant1.name)
          expect(page).to have_content(merchant2.name)
        end
      end
    end
  end
end