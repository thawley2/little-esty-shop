class AdminController < ApplicationController
  def show
    @top_customers = Customer.top_five_customers
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end