require 'rails_helper'

RSpec.describe '/merchants/:merchant_id/items/:id', type: :feature do
  before(:each) do
    test_data
    merchant2_test_data
  end

  describe 'When I visit the merchant item show page' do
    it 'shows all the items attributes (name, description, current selling price)' do
      @item1.update(unit_price: 15000)
      visit merchant_item_path(@merchant, @item1)
      save_and_open_page
      expect(page).to have_content("Little Esty Shop")
      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@item1.name)
      expect(page).to have_content("Description: #{@item1.description}")
      expect(page).to have_content("Current Price: $150.00")
    end
    
    it 'has a link to update an items information' do
      visit merchant_item_path(@merchant, @item1)

      click_link("Update Item")
      expect(current_path).to eq(edit_merchant_item_path(@merchant, @item1))
    end
  end
end