class Item < ApplicationRecord
  include FormatHelper
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  enum status: { 'enabled': 1, 'disabled': 0 }
end