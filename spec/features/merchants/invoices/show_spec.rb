require 'rails_helper'

RSpec.describe '/merchants/merchant_id/invoices/invoice_id)', type: :feature do
  before(:each) do
    merchant2_test_data
  end
  describe "When I visit my merchant's invoice show page" do
    it 'I see information related to that invoice including: id, status, created at, customer name'
      visit merchant_invoice_path(@merchant2)

      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@invoice7.id)
      expect(page).to have_content(@invoice7.status)
      expect(page).to have_content("Created on: #{@invoice7.created_at.strftime("%B/%d/%Y")}")
      expect(page).to have_content("Customer:")
      expect(page).to have_content("#{customer7.full_name}")
  end
end