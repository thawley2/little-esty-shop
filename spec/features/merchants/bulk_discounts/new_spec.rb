require 'rails_helper'

RSpec.describe "/merchants/:id/bulk_discounts/new#new", type: :feature do
  before(:each) do
    test_data
  end

  describe 'When I visit the merchants bulk discounts new page' do
    it 'I see a form to add a new bulk discount' do
      visit new_merchant_bulk_discount_path(@merchant)

      expect(page).to have_content("#{@merchant.name} New")
    end
  end
end