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
    revenue = self.bulk_discounts.where("merchants.id = #{merch_id}")
    .select("invoice_items.*, MIN((invoice_items.quantity * invoice_items.unit_price) * 
      case 
        when invoice_items.quantity >= bulk_discounts.quantity_threshold 
        then (1 - bulk_discounts.percent_discount) 
        else 1 end) as tot_discount_revenue")
    .group('invoice_items.id')

    revenue.sum(&:tot_discount_revenue)
  end

  def total_revenue_merchant_discount
    bulk_discounts
    .select("invoice_items.*, MIN((invoice_items.quantity * invoice_items.unit_price) * 
    case 
      when invoice_items.quantity >= bulk_discounts.quantity_threshold
      then (1 - bulk_discounts.percent_discount) 
    else 1 end) as tot_discount_revenue")
    .group('invoice_items.id')
    .sum(&:tot_discount_revenue)
  end

  def total_revenue_merchant_no_discount
    merchants.where(merchants: {active_discount: false})
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def total_discount_revenue
    self.total_revenue_merchant_no_discount + self.total_revenue_merchant_discount
  end
end

