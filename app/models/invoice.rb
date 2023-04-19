class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum status: {'in progress': 0, 'completed': 1, 'cancelled': 2}

  def self.incomplete_invoices
    joins(:invoice_items)
    .where("invoice_items.status != 2")
    .distinct
    .order(:created_at)
  end

  def format_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def total_revenue
    invoice_items.sum('invoice_items.unit_price * invoice_items.quantity')
  end
end

