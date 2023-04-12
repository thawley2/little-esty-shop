class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  def top_five_customers
    customers.joins(:transactions).group(:id)
  end
end