class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :name, presence: true
  validates :percent_discount, presence: true, numericality: true
  validates :quantity_threshold, presence: true, numericality: true
end