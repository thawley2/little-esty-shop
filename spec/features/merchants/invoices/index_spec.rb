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
      save_and_open_page
      expect(page).to have_content("My Invoices")
      expect(page).to have_content("Invoice ##{@invoice7.id}")
    end
    #And each id links to the merchant invoice show page
  end
end