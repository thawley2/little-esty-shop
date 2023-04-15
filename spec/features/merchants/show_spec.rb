require 'rails_helper'

RSpec.describe 'Merchant Show Dashboard Page', type: :feature do
  let!(:merchant1) {Merchant.create!(name:'Steve')}
  let!(:merchant2) {Merchant.create!(name:'Fred')}

  before(:all) do
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
        
        expect(page).to have_content('Favorite Customers')
        expect(page).to have_content("#{@customer6.first_name} #{@customer6.last_name} - 4 purchases")
        expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name} - 3 purchases")
        expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name} - 2 purchases")
        expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name} - 2 purchases")
        expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name} - 2 purchases")
        expect(page).to_not have_content("#{@customer1.first_name} #{@customer1.last_name}")
        
        expect(@customer6.first_name).to appear_before(@customer2.first_name)
        expect(@customer2.first_name).to appear_before(@customer3.first_name)
        expect(@customer3.first_name).to appear_before(@customer4.first_name)
        expect(@customer4.first_name).to appear_before(@customer5.first_name)
        expect(@customer5.first_name).to_not appear_before(@customer2.first_name)
      end
    end
    
    describe "I see a section for 'Items Ready to Ship'" do
      describe 'shows a list of the names of all of my items that have been ordered and have not yet been shipped,' do
        it "Next to each Item I see the id of the invoice that ordered my item And each invoice id is a link to my merchant's invoice show page" do
          visit merchant_dashboard_path(@merchant)
          
          expect(page).to have_content("Items Ready To Ship")
          expect(page).to have_content("#{@item1.name} - Invoice ##{@invoice2.id}")
          expect(page).to have_content("#{@item2.name} - Invoice ##{@invoice3.id}")
          expect(page).to_not have_content("#{@item3.name} - Invoice ##{@invoice6.id}")
          expect(page).to_not have_content("#{@item1.name} - Invoice ##{@invoice1.id}")
          expect(page).to have_link("#{@invoice2.id}")
          expect(page).to have_link("#{@invoice3.id}")
        end

        it 'has a link to the merchant invoice show page' do
          visit merchant_dashboard_path(@merchant)
          click_link("#{@invoice2.id}")
          
          expect(current_path).to eq(merchant_invoice_path(@merchant.id, @invoice2.id))
        end
        
        it 'I can see the date formatted like "Monday, July 18, 2019"' do
          visit merchant_dashboard_path(@merchant)

          expect(page).to have_content(@invoice2.created_at.strftime("%A %B %d %Y"))
          expect(@invoice2.created_at.strftime("%A %B %d %Y")).to appear_before(@invoice3.created_at.strftime("%A %B %d %Y"))
        end
      end
    end
  end
end

