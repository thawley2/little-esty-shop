class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  def top_5_customers
    self.customers.joins(:transactions)
    .where(transactions: {result: 'success'})
    .select("customers.*, count(transactions.result) as transaction_count")
    .group(:id).order(transaction_count: :desc)
    .limit(5)
  end

  def items_not_shipped
    self.items.joins(:invoices)
    .where("invoice_items.status= 1")
    .select("items.*, invoice_items.invoice_id, invoices.created_at as invoice_creation")
    .distinct
    .order(invoice_creation: :desc)
  end

  def switch_enabled
    update(enabled: !enabled)
  end

  def button_text
    enabled? ? "Disable Merchant" : "Enable Merchant"
  end
end
