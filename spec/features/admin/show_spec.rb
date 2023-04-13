# As an admin,
# W
require 'rails_helper'

RSpec.describe 'Admin Show Dashboard Page', type: :feature do
  before(:each) do
    test_data
  end
  
  describe "As an admin visiting '/admin'" do
    it 'I see a header indicating I am on the admin dashboard' do
      visit admin_dashboard_path
      # save_and_open_page

      within 'h1' do
        expect(page).to have_content('Admin Dashboard')
      end
    end

    it 'I see links to admin merchants and invoices indexes' do
      visit '/admin'
      # save_and_open_page

      within 'div#links' do
        expect(page).to have_link('Admin Merchants')
        expect(page).to have_link('Admin Invoices')
      end
    end

    it 'I see the names of the top 5 customers with the largest number of successful transactions and their transaction count' do
    # require 'pry'; binding.pry
    # customer2 = create(:customer, :with_successful_transactions, transactions_count: 8)
    # customer3 = create(:customer, :with_successful_transactions, transactions_count: 6)
    # customer4 = create(:customer, :with_successful_transactions, transactions_count: 4)
    # customer5 = create(:customer, :with_successful_transactions, transactions_count: 2)
    # customer6 = create(:customer, :with_successful_transactions, transactions_count: 1)
    # customer1 = create(:customer, :with_successful_transactions, transactions_count: 10)
    # require 'pry'; binding.pry
      visit admin_dashboard_path
      save_and_open_page

      within 'section#top-customers' do
        expect(page).to have_content("#{@customer6.full_name} - 4")
        expect(page).to have_content("#{@customer2.full_name} - 3")
        expect(page).to have_content("#{@customer3.full_name} - 2")
        expect(page).to have_content("#{@customer4.full_name} - 2")
        expect(page).to have_content("#{@customer5.full_name} - 2")
        expect(page).not_to have_content("#{@customer1.full_name}")
      end
    end
  end
end