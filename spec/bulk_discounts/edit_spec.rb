require 'rails_helper'

RSpec.describe '/bulk_discounts/:id/edit', type: :feature do
  before(:each) do
    test_data
  end

  describe 'When the edit button is clicked on the show page, I am taken to an edit page' do
    it 'I see a form with all attributes for that discount filled in' do
      visit edit_bulk_discount_path(@discount1)

      expect(page).to have_content("Edit #{@discount1.name} Discount")
      expect(page).to have_field("Discount Name", with: @discount1.name)
      expect(page).to have_field("Percent Discount range:(0.05-1.00)", with: @discount1.percent_discount)
      expect(page).to have_field("Quantity Threshold", with: @discount1.quantity_threshold)
      expect(page).to have_button('Update Bulk discount')

    end

    it 'When I change a value in a field and click update I am taken back to the discounts show page and see the updated info' do
      visit edit_bulk_discount_path(@discount1)

      fill_in 'Discount Name', with: 'Blast Off'

      click_button("Update Bulk discount")

      expect(current_path).to eq(bulk_discount_path(@discount1))
      expect(page).to have_content('Blast Off discount')

      visit edit_bulk_discount_path(@discount1)

      fill_in 'Percent Discount range:(0.05-1.00)', with: 0.1

      click_button("Update Bulk discount")

      expect(current_path).to eq(bulk_discount_path(@discount1))
      expect(page).to have_content('Percent Discount: 10%')
      
      visit edit_bulk_discount_path(@discount1)

      fill_in 'Quantity Threshold', with: 25

      click_button("Update Bulk discount")

      expect(current_path).to eq(bulk_discount_path(@discount1))
      expect(page).to have_content('Quantity Threshold: 25')
    end

    it 'displays an error if a field is left blank when clicking Update' do
      visit edit_bulk_discount_path(@discount1)

      fill_in 'Quantity Threshold', with: ''

      click_button("Update Bulk discount")

      expect(page).to have_content('Please do not leave any fields blank')
      expect(page).to have_content("Edit #{@discount1.name} Discount")
      expect(page).to have_field("Discount Name", with: @discount1.name)
      expect(page).to have_field("Percent Discount range:(0.05-1.00)", with: @discount1.percent_discount)
      expect(page).to have_field("Quantity Threshold")
      expect(page).to have_button('Update Bulk discount')

      fill_in 'Quantity Threshold', with: 25
      click_button("Update Bulk discount")

      expect(current_path).to eq(bulk_discount_path(@discount1))
      expect(page).to have_content('Quantity Threshold: 25')
    end

    it 'displays an error if a number field is filled in with a string and clicking Update' do
      visit edit_bulk_discount_path(@discount1)

      fill_in 'Quantity Threshold', with: 'nothing to see here'

      click_button("Update Bulk discount")

      expect(page).to have_content('Please do not leave any fields blank')
      expect(page).to have_content("Edit #{@discount1.name} Discount")
      expect(page).to have_field("Discount Name", with: @discount1.name)
      expect(page).to have_field("Percent Discount range:(0.05-1.00)", with: @discount1.percent_discount)
      expect(page).to have_field("Quantity Threshold")
      expect(page).to have_button('Update Bulk discount')

      fill_in 'Quantity Threshold', with: 25
      click_button("Update Bulk discount")

      expect(current_path).to eq(bulk_discount_path(@discount1))
      expect(page).to have_content('Quantity Threshold: 25')
    end
  end
end