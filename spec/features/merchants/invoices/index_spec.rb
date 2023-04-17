require 'rails_helper'

RSpec.describe '/merchants/merchant_id/invoices', type: :feature do
  before(:each) do
    merchant2_test_data
  end
  describe "When I visit my merchant's invoices index page" do
    it "Then I see all of the invoices that include at least one of my merchant's items" do
      visit merchant_invoices_path(@merchant2)
      
      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content("My Invoices")
      expect(page).to have_content("Invoice ##{@invoice7.id}")
      expect(page).to have_content("Invoice ##{@invoice8.id}")
      expect(page).to have_content("Invoice ##{@invoice9.id}")
      expect(page).to have_content("Invoice ##{@invoice10.id}")
      expect(page).to have_content("Invoice ##{@invoice11.id}")
      expect(page).to have_content("Invoice ##{@invoice12.id}")
      expect(page).to have_content("Invoice ##{@invoice13.id}")
    end
    it 'each id links to the merchant invoice show page' do
      visit merchant_invoices_path(@merchant2)
      
      click_link("#{@invoice7.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant2, @invoice7))
      
      visit merchant_invoices_path(@merchant2)
      click_link("#{@invoice8.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant2, @invoice8))
      
      visit merchant_invoices_path(@merchant2)
      click_link("#{@invoice9.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant2, @invoice9))
      
      visit merchant_invoices_path(@merchant2)
      click_link("#{@invoice10.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant2, @invoice10))
    end
  end
end