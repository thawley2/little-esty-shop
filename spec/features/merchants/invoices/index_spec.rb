require 'rails_helper'

RSpec.describe '/merchants/merchant_id/invoices', type: :feature do
  before(:each) do
    test_data
    merchant2_test_data
  end
  describe "When I visit my merchant's invoices index page" do
    it "Then I see all of the invoices that include at least one of my merchant's items" do
      
    end

    xit "For each invoice I see its id and each id links to the merchant invoice show page" do
  end
end