require 'rails_helper'

RSpec.describe '/merchants/:id/bulk_discounts#index', type: :feature do
  before(:each) do
    test_data
  end

  describe 'When a merchant visits their bulk discount index page' do
    it 'I see all of my bulk discounts including their percentage discount and quantity thresholds' do
      visit merchant_bulk_discounts_path(@merchant)

      expect(page).to have_content("#{@merchant.name} Discounts")
      expect(page).to have_content("List of all active discounts")

      within "#disc_#{@discount1.id}" do
        expect(page).to have_content("Discount Name: #{@discount1.name} discount")
        expect(page).to have_content("Discount Percentage: 30%")
        expect(page).to have_content("Quantity Threshold: #{@discount1.quantity_threshold}")
      end
      within "#disc_#{@discount2.id}" do
        expect(page).to have_content("Discount Name: #{@discount2.name} discount")
        expect(page).to have_content("Discount Percentage: 20%")
        expect(page).to have_content("Quantity Threshold: #{@discount2.quantity_threshold}")
      end
      expect(page).to_not have_content(@discount3.name)
    end

    it 'Each of the discounts names is a link to their show page' do
      visit merchant_bulk_discounts_path(@merchant)

      expect(page).to have_link("#{@discount1.name} discount")
      expect(page).to have_link("#{@discount2.name} discount")

      click_link("#{@discount1.name} discount")

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount1))
    end

    it 'I see a link to create a new discount' do
      visit merchant_bulk_discounts_path(@merchant)

      expect(page).to have_link()
    end
  end
end