require 'rails_helper'

RSpec.describe '/merchants/:id/bulk_discounts/:id', type: :feature do
  before(:each) do
    test_data
  end

  describe 'When I visit a discounts show page' do
    it 'I see the discounts name' do
      visit merchant_bulk_discount_path(@merchant, @discount1)

      expect(page).to have_content("#{@discount1.name} discount")
    end
  end
end