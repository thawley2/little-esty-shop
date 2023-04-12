# 1. Merchant Dashboard

# As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
require 'rails_helper'

RSpec.describe 'Merchant Show Dashboard Page', type: :feature do
  let!(:merchant1) {Merchant.create!(name:'Steve')}
  let!(:merchant2) {Merchant.create!(name:'Fred')}

  before(:each) do
    test_data
  end

  describe "As a merchant visiting '/merchants/:id/dashboard'" do
    it 'I see the name of my merchant' do
      visit merchant_dashboard_path(merchant1)
      
      expect(page).to have_content('Steve')
    end
    
    it 'has a link to merchant items index' do
      visit merchant_dashboard_path(merchant1)
      
      expect(page).to have_link('My Items')
      click_link("My Items")
      expect(current_path).to eq(merchant_items_path(merchant1))
    end
    
    it 'has a link to merchant invoice index' do
      visit merchant_dashboard_path(merchant1)
      
      expect(page).to have_link('My Invoices')
      click_link("My Invoices")
      expect(current_path).to eq(merchant_invoices_path(merchant1))
    end

    describe 'shows the names of the top 5 customers' do
      it 'who have conducted the largest number of successful transactions with my merchant' do
        visit merchant_dashboard_path(@merchant)
        require 'pry'; binding.pry
        expect(page).to have_content('Favorite Customers')
        expect(page).to have_content("1. #{@customer1.first_name} #{@customer1.last_name} - 4 purchases")
        expect(page).to have_content("2. #{@customer2.first_name} #{@customer2.last_name} - 3 purchases")
        expect(page).to have_content("3. #{@customer3.first_name} #{@customer3.last_name} - 2 purchases")
        expect(page).to have_content("4. #{@customer4.first_name} #{@customer4.last_name} - 1 purchases")
        expect(page).to have_content("5. #{@customer5.first_name} #{@customer5.last_name} - 1 purchases")
      end
    end
  end
end

