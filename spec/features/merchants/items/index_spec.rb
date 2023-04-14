require 'rails_helper'

RSpec.describe '/merchants/:id/items' do
  before(:each) do
    test_data
    merchant2
  end
  describe 'When I visit my merchant items index page' do
    it 'I see a list of the names of all of my items and not other merchant items' do
      visit merchant_items_path(@merchant)
# save_and_open_page
      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item5.name)
      expect(page).to_not have_content(@merchant2.name)
      expect(page).to_not have_content(@item6.name)
      expect(page).to_not have_content(@item7.name)
      expect(page).to_not have_content(@item8.name)
      expect(page).to_not have_content(@item9.name)
      expect(page).to_not have_content(@item10.name)
    end
  end
end