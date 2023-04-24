class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants
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

  def inv_total_rev_discs(merch_id)
    bulk_discounts.where(bulk_discounts: {merchant_id: merch_id})
    .sum("((invoice_items.quantity * invoice_items.unit_price) * 
      case 
        when invoice_items.quantity >= bulk_discounts.quantity_threshold 
        then (1 - bulk_discounts.percent_discount) 
      else 1 end)")
  end
end

