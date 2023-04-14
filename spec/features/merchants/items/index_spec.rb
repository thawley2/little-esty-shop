require 'rails_helper'

RSpec.describe '/merchants/:id/items', type: :feature do
  before(:each) do
    test_data
    merchant2_test_data
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

    describe 'When I click on the name of an item from the merchant items index page' do
      it 'Then I am taken to that merchants items show page' do
        visit merchant_items_path(@merchant)

      expect(page).to have_link("#{@item1.name}")
      expect(page).to have_link("#{@item2.name}")
      expect(page).to have_link("#{@item3.name}")
      expect(page).to have_link("#{@item4.name}")
      expect(page).to have_link("#{@item5.name}")

      click_link("#{@item1.name}")

      expect(current_path).to eq(merchant_item_path(@merchant, @item1))
      end
    end
  end
end