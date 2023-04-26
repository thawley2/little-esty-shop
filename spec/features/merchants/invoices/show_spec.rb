require 'rails_helper'

RSpec.describe '/merchants/merchant_id/invoices/invoice_id)', type: :feature do
  describe "When I visit my merchant's invoice show page" do
    it 'I see information related to that invoice including: id, status, created at, customer name' do
      test_data
      merchant2_test_data
      visit merchant_invoice_path(@merchant2, @invoice7)

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@invoice7.id)
      expect(page).to have_content(@invoice7.status)
      expect(page).to have_content("Created on: #{@invoice7.created_at.strftime("%B/%d/%Y")}")
      expect(page).to have_content("Customer:")
      expect(page).to have_content("#{@customer7.full_name}")

      visit merchant_invoice_path(@merchant, @invoice1)

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content("Created on: #{@invoice1.created_at.strftime("%B/%d/%Y")}")
      expect(page).to have_content("Customer:")
      expect(page).to have_content("#{@customer1.full_name}")
    end

    it 'I see all of my items on the invoice (name, quantity ordered, price the item sold for and invoice item status)' do
      merchant3_test_data
      visit merchant_invoice_path(@merchant2, @invoice7)

      expect(page).to have_content("Items on this Invoice:")
      within "#item_#{@init1.id}" do
        expect(page).to have_content(@item6.name)
        expect(page).to have_content(@init1.quantity)
        expect(page).to have_content(@init1.unit_price)
        expect(page).to have_content(@init1.status)
      end
      within "#item_#{@init8.id}" do
        expect(page).to have_content(@item11.name)
        expect(page).to have_content(@init8.quantity)
        expect(page).to have_content(@init8.unit_price)
        expect(page).to have_content(@init8.status)
      end
      expect(page).to_not have_content(@item12.name) 
    end
    
    it 'I see the total revenue that will be generated from all of my items on the invoice' do
      merchant3_test_data
      visit merchant_invoice_path(@merchant2, @invoice7)
      
      expect(page).to have_content("Total Revenue: $175.00")
    end

    it 'I see the total revenue that will be generated from all items with discounts' do
      merchant3_test_data
      visit merchant_invoice_path(@merchant2, @invoice7)
      
      expect(page).to have_content("Total Revenue With Discounts: $167.50")

    end

    it 'Shows the original revenue if no discounts were applied' do
      merchant3_test_data
      visit merchant_invoice_path(@merchant3, @invoice7)

      expect(page).to have_content("Total Revenue: $131.25")
      expect(page).to have_content("Total Revenue With Discounts: $131.25")
    end
  end

  describe "I see that each invoice item status is a select field with it's current status selected" do
    it 'can change the status of an item' do
      merchant3_test_data
      @init1.update(status: 0)
      visit merchant_invoice_path(@merchant2, @invoice7)
      
      within "#item_#{@init1.id}" do
        expect(page).to have_selector("#invitm", text: "pending")
        select('packaged', from: 'Status')

        expect(page).to have_button("Update Item Status")

        click_button("Update Item Status")

        expect(current_path).to eq(merchant_invoice_path(@merchant2, @invoice7))
        expect(page).to have_selector("#invitm", text: 'packaged')

        select('shipped', from: 'Status')
        click_button("Update Item Status")

        expect(current_path).to eq(merchant_invoice_path(@merchant2, @invoice7))
        expect(page).to have_selector("#invitm", text: 'shipped')
      end
    end

    describe 'If a discount was applied to that invoice item' do
      it 'I see a link to that discounts show page or a message with no discount applied' do

        merchant3_test_data
        @discount2 = create(:bulk_discount, percent_discount: 0.20, quantity_threshold: 10, merchant: @merchant2)
        @init20 = create(:invoice_item, item: @item8, invoice: @invoice7, unit_price: 500, quantity: 5)
        visit merchant_invoice_path(@merchant2, @invoice7)
        
        within "#item_#{@init1.id}" do
          expect(page).to have_link('View Discount')
          click_link('View Discount')
          expect(current_path).to eq(bulk_discount_path(@discount2))
        end

        visit merchant_invoice_path(@merchant2, @invoice7)

        within "#item_#{@init8.id}" do
          expect(page).to have_link('View Discount')
          click_link('View Discount')
          expect(current_path).to eq(bulk_discount_path(@discount2))
        end
        
        visit merchant_invoice_path(@merchant2, @invoice7)

        within "#item_#{@init20.id}" do
          expect(page).to have_content('No Discount Applied')
        end
      end
    end
  end
end
