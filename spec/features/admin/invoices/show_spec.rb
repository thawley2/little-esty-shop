require 'rails_helper'

RSpec.describe 'Invoice Index' do
  describe 'when I visit the admin invoice index' do
    it 'US33 I see a list of all invoice ids' do
      test_data
      visit admin_invoice_path(@invoice1)
      save_and_open_page
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.customer.full_name)
    end
  end
end