require 'rails_helper'

RSpec.describe "/merchants/:id/bulk_discounts/new#new", type: :feature do
  before(:each) do
    test_data
  end

  describe 'When I visit the merchants bulk discounts new page' do
    it 'I see a form to add a new bulk discount' do
      visit new_merchant_bulk_discount_path(@merchant)

      expect(page).to have_content("#{@merchant.name} New Discount")
      expect(page).to have_field("Discount Name")
      expect(page).to have_field("Percent Discount range:(0.05-1.00)")
      expect(page).to have_field("Quantity Threshold")
      expect(page).to have_button("Create Bulk discount")
    end

    it 'When I fill in the form with valid data and click Create, I am taken back to the bulk discount index page and see the new discount' do
      visit new_merchant_bulk_discount_path(@merchant)

      fill_in 'Discount Name', with: 'Flash Deal'
      fill_in 'Percent Discount range:(0.05-1.00)', with: 0.25
      fill_in 'Quantity Threshold', with: 5

      click_button 'Create Bulk discount'

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    end
  end
end