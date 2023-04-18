require 'rails_helper'

RSpec.describe 'Invoice Index' do
  describe 'when I visit the admin invoice index' do
    it 'US33 I see a list of all invoice ids' do
      test_data
      visit admin_invoice_path(@invoice1)

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.customer.full_name)
    end

    it 'US34 I see all of the items on the invoice with their data' do
      test_data
      visit admin_invoice_path(@invoice1)

      expect(page).to have_content(@inv_itm1.item.name)
      expect(page).to have_content(@inv_itm1.quantity)
      expect(page).to have_content("Price: $#{@inv_itm1.unit_price / 100.0}")
      expect(page).to have_content(@inv_itm1.status)
    end
  end
end

# Item name
# The quantity of the item ordered
# The price the Item sold for
# The Invoice Item status
