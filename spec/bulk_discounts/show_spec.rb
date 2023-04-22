require 'rails_helper'

RSpec.describe 'bulk_discounts/:id', type: :feature do
  before(:each) do
    test_data
  end

  describe 'When I visit a discounts show page' do
    it 'I see the discounts name' do
      visit bulk_discount_path(@discount1)
      
      expect(page).to have_content("#{@discount1.name} discount")
      expect(page).to have_content("Quantity Threshold: #{@discount1.quantity_threshold}")
      expect(page).to have_content("Percent Discount: 30%")

      visit bulk_discount_path(@discount2)

      expect(page).to have_content("#{@discount2.name} discount")
      expect(page).to have_content("Quantity Threshold: #{@discount2.quantity_threshold}")
      expect(page).to have_content("Percent Discount: 20%")
    end

    it 'I see a button to edit the bulk discount record, when clicked I am taken to the edit page' do
      visit bulk_discount_path(@discount1)

      expect(page).to have_button('Edit')

      click_button('Edit')

      expect(current_path).to eq(edit_bulk_discount_path(@discount1))
    end
  end
end