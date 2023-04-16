def test_data
  @merchant = create(:merchant)

  @item1 = create(:item, merchant: @merchant)
  @item2 = create(:item, merchant: @merchant)
  @item3 = create(:item, merchant: @merchant)
  @item4 = create(:item, merchant: @merchant)
  @item5 = create(:item, merchant: @merchant)

  @customer1 = create(:customer)
  @customer2 = create(:customer)
  @customer3 = create(:customer)
  @customer4 = create(:customer)
  @customer5 = create(:customer)
  @customer6 = create(:customer)

  @invoice1 = create(:invoice, customer: @customer1)
  @invoice2 = create(:invoice, customer: @customer2)
  @invoice3 = create(:invoice, customer: @customer3)
  @invoice4 = create(:invoice, customer: @customer4)
  @invoice5 = create(:invoice, customer: @customer5)
  @invoice6 = create(:invoice, customer: @customer6)
  

  @transaction1 = create(:transaction, result: 'success', invoice: @invoice6)
  @transaction2 = create(:transaction, result: 'success', invoice: @invoice6)
  @transaction3 = create(:transaction, result: 'success', invoice: @invoice6)
  @transaction4 = create(:transaction, result: 'success', invoice: @invoice6)
  @transaction5 = create(:transaction, result: 'success', invoice: @invoice2)
  @transaction6 = create(:transaction, result: 'success', invoice: @invoice2)
  @transaction7 = create(:transaction, result: 'success', invoice: @invoice2)
  @transaction8 = create(:transaction, result: 'success', invoice: @invoice3)
  @transaction9 = create(:transaction, result: 'success', invoice: @invoice3)
  @transaction10 = create(:transaction, result: 'success', invoice: @invoice4)
  @transaction14 = create(:transaction, result: 'success', invoice: @invoice4)
  @transaction11 = create(:transaction, result: 'success', invoice: @invoice5)
  @transaction12 = create(:transaction, result: 'success', invoice: @invoice5)
  @transaction13 = create(:transaction, result: 'success', invoice: @invoice1)

  @inv_itm1 = create(:invoice_item, item: @item1, invoice: @invoice1, status: 2)
  @inv_itm2 = create(:invoice_item, item: @item1, invoice: @invoice2, status: 1)
  @inv_itm3 = create(:invoice_item, item: @item2, invoice: @invoice3, status: 1)
  @inv_itm4 = create(:invoice_item, item: @item2, invoice: @invoice4, status: 0)
  @inv_itm5 = create(:invoice_item, item: @item3, invoice: @invoice5, status: 0)
  @inv_itm6 = create(:invoice_item, item: @item3, invoice: @invoice6, status: 2)
end

def merchant2_test_data
  @merchant2 = create(:merchant)

  @item6 = create(:item, merchant: @merchant2)
  @item7 = create(:item, merchant: @merchant2)
  @item8 = create(:item, merchant: @merchant2)
  @item9 = create(:item, merchant: @merchant2)
  @item10 = create(:item, merchant: @merchant2)
  @item11 = create(:item, merchant: @merchant2)
  @item12 = create(:item, merchant: @merchant2)

  @customer7 = create(:customer)
  @customer8 = create(:customer)
  @customer9 = create(:customer)
  @customer10 = create(:customer)
  @customer11 = create(:customer)
  @customer12 = create(:customer)

  @invoice7 = create(:invoice, customer: @customer7)
  @invoice8 = create(:invoice, customer: @customer8)
  @invoice9 = create(:invoice, customer: @customer9)
  @invoice10 = create(:invoice, customer: @customer10)
  @invoice11 = create(:invoice, customer: @customer11)
  @invoice12 = create(:invoice, customer: @customer12)
  @invoice13 = create(:invoice, customer: @customer12)

  @tran1 = create(:transaction, result: 'success', invoice: @invoice7)
  @tran2 = create(:transaction, result: 'failed', invoice: @invoice7)
  @tran3 = create(:transaction, result: 'failed', invoice: @invoice8)
  @tran4 = create(:transaction, result: 'failed', invoice: @invoice8)
  @tran5 = create(:transaction, result: 'success', invoice: @invoice9)
  @tran6 = create(:transaction, result: 'success', invoice: @invoice10)
  @tran7 = create(:transaction, result: 'success', invoice: @invoice11)
  @tran8 = create(:transaction, result: 'success', invoice: @invoice12)
  @tran9 = create(:transaction, result: 'success', invoice: @invoice13)
  
  @init1 = create(:invoice_item, item: @item6, invoice: @invoice7, unit_price: 1000, quantity: 10)
  @init2 = create(:invoice_item, item: @item7, invoice: @invoice8, unit_price: 10000, quantity: 1000)
  @init3 = create(:invoice_item, item: @item8, invoice: @invoice9, unit_price: 1000, quantity: 100)
  @init4 = create(:invoice_item, item: @item9, invoice: @invoice10, unit_price: 100, quantity: 10)
  @init5 = create(:invoice_item, item: @item10, invoice: @invoice11, unit_price: 1, quantity: 10)
  @init6 = create(:invoice_item, item: @item11, invoice: @invoice12, unit_price: 1000000, quantity: 10)
  @init7 = create(:invoice_item, item: @item12, invoice: @invoice13, unit_price: 10, quantity: 10)
end
# item11, item8, item6, item9, item12
# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
     with.test_framework :rspec
     with.library :rails
  end
end
