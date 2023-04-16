class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  enum status: { 'enabled': 1, 'disabled': 0 }

  def best_sell_date
    invoices.joins(:transactions)
    .where(transactions: {result: 'success'})
    .select("invoices.*, count(transactions)")
    .group(:id)
    .order(count: :desc)
    .pluck(:created_at)
    .first
  end
end