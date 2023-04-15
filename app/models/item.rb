class Item < ApplicationRecord
  include FormatHelper
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end