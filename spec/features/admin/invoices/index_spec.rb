require 'rails_helper'

RSpec.describe 'Invoice Index' do
  describe 'when I visit the admin invoice index' do
    it 'US32 I see a list of all invoice ids' do
      test_data
      visit admin_invoices_path
      
      expect(page).to have_link(@invoice1.id)
      expect(page).to have_link(@invoice2.id)
      expect(page).to have_link(@invoice3.id)
      expect(page).to have_link(@invoice4.id)
      expect(page).to have_link(@invoice5.id)

      click_link(@invoice6.id)
      save_and_open_page
      expect(current_path).to eq(admin_invoice_path(@invoice6))
    end
  end
end