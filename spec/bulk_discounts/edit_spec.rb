require 'rails_helper'

RSpec.describe '/bulk_discounts/:id/edit', type: :feature do
  before(:each) do
    test_data
  end

  describe 'When the edit button is clicked on the show page, I am taken to an edit page' do
    it 'I see a form with all attributes for that discount filled in' do
      visit edit_bulk_discount_path(@discount1)

      expect(page).to have_content("Edit #{@discount1.name} Discount")
      expect(page).to have_field("Discount Name")
      expect(page).to have_field("Percent Discount range:(0.05-1.00)")
      expect(page).to have_field("Quantity Threshold")
      expect(page.has_field?("Discount Name", with: @discount1.name)).to be true
      expect(page.has_field?("Percent Discount range:(0.05-1.00)", with: @discount1.percent_discount)).to be true
      expect(page.has_field?("Quantity Threshold", with: @discount1.quantity_threshold)).to be true
      expect(page).to have_button('Update Bulk discount')

    end

    it 'When I '
  end
end