require 'rails_helper'

RSpec.describe 'Merchant Index' do
  describe 'As an admin' do
    let!(:merchant1) {Merchant.create!(name:'Steve', enabled: false)}
    let!(:merchant2) {Merchant.create!(name:'Fred', enabled: true)}
  
    before do
      top_five_merchants  
    end

    describe 'When I visit the admin merchants index' do
      it 'I see the name of each merchant in the system' do
        visit admin_merchants_path

        expect(page).to have_content('Merchants Index')

        expect(page).to have_content(merchant1.name)
        expect(page).to have_content(merchant2.name)
      end

      it 'I click the name of a merchant' do
        visit admin_merchants_path

        click_link(merchant1.name)
        expect(current_path).to eq(admin_merchant_path(merchant1))
      end
      
      it 'I see sections for enabled/disabled merchants with enable/disable buttons next to their names' do
        visit admin_merchants_path
      
        within ".disabled_merchants .merchant#{merchant1.id}" do
          click_button "Enable #{merchant1.name}"
          expect(current_path).to eq(admin_merchants_path)
        end

        expect(page).to have_content("Steve is Enabled")
        
        within ".enabled_merchants" do
          within ".merchant#{merchant2.id}" do
            expect(page).to have_button("Disable #{merchant2.name}")
          end

          within ".merchant#{merchant1.id}" do
            click_button "Disable #{merchant1.name}"
            expect(current_path).to eq(admin_merchants_path)
          end
        end
        expect(page).to have_content("Steve is Disabled")
      end

      it 'I see a link to create a new merchant with a default status of disabled' do
        visit admin_merchants_path
        
        expect(page).not_to have_content('Marchand')
  
        click_link 'Create New Merchant'
        expect(current_path).to eq(new_admin_merchant_path)
  
        fill_in 'Name', with: 'Marchand'
        click_button 'Create Merchant'

        expect(current_path).to eq(admin_merchants_path)
  
        within '.disabled_merchants' do
          expect(page).to have_content('Marchand')
        end
  
        expect(page).to have_content('Marchand was successfully created')
      end

      it "Then I see the names of the top 5 merchants by total revenue generated 
      and I see that each merchant name links to the admin merchant show page 
      for that merchant and I see the total revenue generated next to  each merchant name" do
        visit admin_merchants_path
        
        within(".top-five-merchants") do
          @top_five.each do |merch|
            expect(page).to have_link(merch.name)
            # expect(page).to have_content("Top selling date for #{merch.name} was #{merch.best_day}")
          end
        
          expect(@merchant6.name).to appear_before(@merchant5.name)
          
          expect(@merchant5.name).to appear_before(@merchant4.name)
          expect(@merchant4.name).to appear_before(@merchant3.name)
          expect(@merchant3.name).to appear_before(@merchant2.name)
          expect(page).to have_content('$50.00')
          expect(page).to have_content('$30.00')
          
          click_link(@merchant5.name)
          expect(current_path).to eq(admin_merchant_path(@merchant5))
        end
      end
    end
  end
end