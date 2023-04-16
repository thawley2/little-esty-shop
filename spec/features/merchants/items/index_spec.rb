require 'rails_helper'

RSpec.describe '/merchants/:id/items', type: :feature do
  before(:each) do
    test_data
    merchant2_test_data
  end
  describe 'When I visit my merchant items index page' do
    it 'I see a list of the names of all of my items and not other merchant items' do
      visit merchant_items_path(@merchant)

      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item5.name)
      expect(page).to_not have_content(@merchant2.name)
      expect(page).to_not have_content(@item6.name)
      expect(page).to_not have_content(@item7.name)
      expect(page).to_not have_content(@item8.name)
      expect(page).to_not have_content(@item9.name)
      expect(page).to_not have_content(@item10.name)
    end

    describe 'When I click on the name of an item from the merchant items index page' do
      it 'Then I am taken to that merchants items show page' do
        visit merchant_items_path(@merchant)

        within "#item_#{@item2.id}" do
          expect(page).to have_link("#{@item2.name}")
        end
        within "#item_#{@item3.id}" do
          expect(page).to have_link("#{@item3.name}")
        end
        within "#item_#{@item4.id}" do
          expect(page).to have_link("#{@item4.name}")
        end
        within "#item_#{@item5.id}" do
          expect(page).to have_link("#{@item5.name}")
        end
        within "#item_#{@item1.id}" do
          expect(page).to have_link("#{@item1.name}")
          click_link("#{@item1.name}")
          expect(current_path).to eq(merchant_item_path(@merchant, @item1))
        end
        
      end
    end

    describe 'I see a button next to each item to enable or disable' do
      it 'where the button is enabled for disabled items' do
        @item1.update(status: 1)
        @item3.update(status: 1)
        visit merchant_items_path(@merchant)

        expect(page).to have_content('Disabled Items')
        within "#item_#{@item2.id}" do
          expect(page).to have_button("Enable")
          click_button('Enable')
          expect(current_path).to eq(merchant_items_path(@merchant))
          expect(page).to have_button("Disable")
        end

        within "#item_#{@item4.id}" do
          expect(page).to have_button("Enable")
        end

        within "#item_#{@item5.id}" do
          expect(page).to have_button("Enable")
        end

        within "#item_#{@item1.id}" do
          expect(page).to_not have_button("Enable")
        end

        within "#item_#{@item3.id}" do
          expect(page).to_not have_button("Enable")
        end
      end

      it 'where the button is disabled for enabled items' do
        @item1.update(status: 1)
        @item3.update(status: 1)

        visit merchant_items_path(@merchant)

        expect(page).to have_content('Enabled Items')
        within "#item_#{@item1.id}" do
          expect(page).to have_button("Disable")
          click_button('Disable')
          expect(current_path).to eq(merchant_items_path(@merchant))
          expect(page).to have_button("Enable")
        end

        within "#item_#{@item3.id}" do
          expect(page).to have_button("Disable")
        end
        
        within "#item_#{@item5.id}" do
          expect(page).to_not have_button("Disable")
        end
      end
    end

    describe 'I see a link to create a new item.' do
      it 'When I click on the link, I am taken to a form that allows me to add item information.' do
        visit merchant_items_path(@merchant)

        expect(page).to have_link("New Item")
        click_link("New Item")

        expect(current_path).to eq(new_merchant_item_path(@merchant))
      end
    end

    describe 'I see the names of the top 5 most popular items ranked by total revenue generated' do
      describe 'And I see that each item name links to my merchant item show page for that item' do
        it 'And I see the total revenue generated next to each item name' do
          #item11, item8, item6, item9, item12
          visit merchant_items_path(@merchant2)

          expect(page).to have_content('Top Items')

          within "#top_items" do
            expect(@item11.name).to appear_before(@item8.name)
            expect(@item8.name).to appear_before(@item6.name)
            expect(@item6.name).to appear_before(@item9.name)
            expect(@item9.name).to appear_before(@item12.name)
            expect(@item12.name).to_not appear_before(@item11.name)
            expect(page).to_not have_content(@item12)
            expect(page).to_not have_content(@item7)
          end
          
          within "#top_item_#{@item11.id}" do
            expect(page).to have_content('$100,431.00 in sales')
          end
          within "#top_item_#{@item8.id}" do
            expect(page).to have_content('$1,000.00 in sales')
          end
          within "#top_item_#{@item6.id}" do
            expect(page).to have_content('$400.00 in sales')
          end
          within "#top_item_#{@item9.id}" do
            expect(page).to have_content('$10.00 in sales')
          end
          within "#top_item_#{@item12.id}" do
            expect(page).to have_content('$1.00 in sales')
          end

          within "#top_items" do
            expect(page).to have_link("#{@item11.name}")
          end
          within "#top_items" do
            expect(page).to have_link("#{@item8.name}")
          end
          within "#top_items" do
            expect(page).to have_link("#{@item6.name}")
          end
          within "#top_items" do
            expect(page).to have_link("#{@item9.name}")
          end
          within "#top_items" do
            expect(page).to have_link("#{@item12.name}")
            click_link "#{@item12.name}"
            expect(current_path).to eq(merchant_item_path(@merchant2, @item12))
          end
        end

        it 'Next to each item I see the date with the most sales for each item (Top selling date for <item name> was <date with most sales>)' do
          @invoice7.update(created_at: '23 Oct 2021')
          visit merchant_items_path(@merchant2)

          within "#top_item_#{@item11.id}" do
            expect(page).to have_content("Top day for #{@item11.name} was #{@invoice7.created_at.strftime("%m/%d/%y")}")
          end
          within "#top_item_#{@item8.id}" do
            expect(page).to have_content("Top day for #{@item8.name} was #{@invoice9.created_at.strftime("%m/%d/%y")}")
          end
          within "#top_item_#{@item6.id}" do
            expect(page).to have_content("Top day for #{@item6.name} was #{@invoice7.created_at.strftime("%m/%d/%y")}")
          end
          within "#top_item_#{@item9.id}" do
            expect(page).to have_content("Top day for #{@item9.name} was #{@invoice10.created_at.strftime("%m/%d/%y")}")
          end
          within "#top_item_#{@item12.id}" do
            expect(page).to have_content("Top day for #{@item12.name} was #{@invoice13.created_at.strftime("%m/%d/%y")}")
          end
        end
      end
    end
  end
end