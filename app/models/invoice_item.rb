class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: { 'pending': 0, 'packaged': 1, 'shipped': 2 }

  def applied_discount
    item.merchant.bulk_discounts
    .where("#{self.quantity} >= bulk_discounts.quantity_threshold")
    .order("bulk_discounts.percent_discount DESC")
    .first
  end
end