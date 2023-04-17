require 'rails_helper'

RSpec.describe '/merchants/merchant_id/invoices', type: :feature do
  before(:each) do
    merchant2_test_data
  end
  describe "When I visit my merchant's invoices index page" do
    it "Then I see all of the invoices that include at least one of my merchant's items" do
      visit merchant_invoices_path(@merchant)

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content(@merchant.name)
      expect(page).to have_content("My Invoices")
      expect(page).to have_content("Invoice #{@invoice.id}")
    end
  end
end