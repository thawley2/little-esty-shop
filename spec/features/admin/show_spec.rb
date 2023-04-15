
require 'rails_helper'

RSpec.describe 'Admin Show Dashboard Page', type: :feature do
  before(:all) do
    test_data
  end
  
  describe "As an admin visiting '/admin'" do
    it 'I see a header indicating I am on the admin dashboard' do
      visit admin_dashboard_path

      within 'h1' do
        expect(page).to have_content('Admin Dashboard')
      end
    end

    it 'I see links to admin merchants and invoices indexes' do
      visit '/admin'

      within 'div#links' do
        expect(page).to have_link('Admin Merchants')
        expect(page).to have_link('Admin Invoices')
      end
    end

    it 'I see the names of the top 5 customers with the largest number of successful transactions and their transaction count' do
      visit admin_dashboard_path

      within 'section#top-customers' do
        expect(page).to have_content("#{@customer6.full_name} - 4")
        expect(page).to have_content("#{@customer2.full_name} - 3")
        expect(page).to have_content("#{@customer3.full_name} - 2")
        expect(page).to have_content("#{@customer4.full_name} - 2")
        expect(page).to have_content("#{@customer5.full_name} - 2")
        expect(page).not_to have_content("#{@customer1.full_name}")

        expect(@customer6.first_name).to appear_before(@customer2.first_name)
        expect(@customer3.first_name).to appear_before(@customer4.first_name)
        expect(@customer4.first_name).to appear_before(@customer5.first_name)
        expect(@customer5.first_name).to_not appear_before(@customer2.first_name)
      end
    end

  describe 'Incomplete Invoices Section' do
    it 'I see a section for "Incomplete Invoices" with ids of all unshipped invoices as links to invoice admin show page' do
      visit admin_dashboard_path

      within 'section#incomplete-invoices' do
        expect(page).to have_content("Incomplete Invoices")

        expect(page).to have_link("Invoice: #{@invoice2.id}")
        expect(page).to have_link("Invoice: #{@invoice3.id}")
        expect(page).to have_link("Invoice: #{@invoice4.id}")
        expect(page).to have_link("Invoice: #{@invoice5.id}")
        
        click_link("Invoice: #{@invoice2.id}")
        expect(current_path).to eq("/admin/invoices/#{@invoice2.id}")
      end
    end
  end

    it 'In the section for "Incomplete Invoices" and next to each invoice id I see the date formatted that the invoice was created at and the list is ordered from oldest to newest ' do
      visit admin_dashboard_path
      save_and_open_page

      within 'section#incomplete-invoices' do
          expect(page).to have_content(@invoice2.format_date)
          expect(Invoice.incomplete_invoices[0].format_date).to appear_before(Invoice.incomplete_invoices[1].format_date)
          expect(Invoice.incomplete_invoices[1].format_date).to appear_before(Invoice.incomplete_invoices[2].format_date)
      end
    end
  end
end

