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
      expect(page).to have_content('Discount Name: Flash Deal')
    end

    it 'When I leave a field empty and click submit' do
      visit new_merchant_bulk_discount_path(@merchant)
      fill_in 'Discount Name', with: 'Flash Deal'
      fill_in 'Quantity Threshold', with: 5

      click_button 'Create Bulk discount'

      expect(page).to have_field("Discount Name")
      expect(page).to have_field("Percent Discount range:(0.05-1.00)")
      expect(page).to have_field("Quantity Threshold")
      expect(page).to have_button("Create Bulk discount")
      expect(page).to have_content('Please fill out all required fields')
    end

    it 'merchant has a active_discount status of true when it has bulk discounts 
      until all bulk discounts are deleted the status is switched to false' do
      merchant = Merchant.create(name: 'hi', enabled: true)
      visit new_merchant_bulk_discount_path(merchant)
      
      expect(merchant.active_discount).to eq(false)

      fill_in 'Discount Name', with: 'Flash Deal'
      fill_in 'Percent Discount range:(0.05-1.00)', with: 0.25
      fill_in 'Quantity Threshold', with: 5

      click_button 'Create Bulk discount'

      expect(current_path).to eq(merchant_bulk_discounts_path(merchant))
      merchant.reload
      expect(merchant.active_discount).to be true

      click_button 'Delete Discount' 
      merchant.reload
      expect(merchant.active_discount).to be false
    end
  end
end