class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.top_five_customers
    joins(invoices: :transactions)
      .where(transactions: { result: 'success' })
      .group('customers.id')
      .select('customers.*, COUNT(transactions.id) AS successful_transaction_count')
      .order('successful_transaction_count DESC')
      .limit(5)
  end
end