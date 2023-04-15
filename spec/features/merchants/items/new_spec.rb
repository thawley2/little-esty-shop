require 'rails_helper'

RSpec.describe '/merchants/:id/items/new', type: :feature do
  before(:each) do
    test_data
    merchant2_test_data
  end
  describe "When I fill out the form I click Submit" do
    describe "Then I am taken back to the items index page" do
      it 'And I see the item I just created displayed in the list of items.' do
        visit new_merchant_item_path(@merchant)
# save_and_open_page
        expect(page).to have_field('Name')
        expect(page).to have_field('Description')
        expect(page).to have_field('Unit Price')
        expect(page).to have_content('Name')
        expect(page).to have_content('Description')
        expect(page).to have_content('Unit Price')

        fill_in 'Name', with: 'Soggy Bottoms'
        fill_in 'Description', with: 'The soggiest of bottoms'
        fill_in 'Unit Price', with: 20000

        click_button("Submit")

        expect(current_path).to eq(merchant_items_path(@merchant))
        new_item = Item.where(name: 'Soggy Bottoms')

        within "#item_#{new_item.id}" do
          expect(page).to have_button("Enable")
          expect(page).to have_content("Soggy Bottoms")
        end
      end

      xit 'And I see my item was created with a default status of disabled.' do
        visit merchant_items_path(@merchant)


      end
    end
  end
end