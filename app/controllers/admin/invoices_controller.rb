class Admin::InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    require 'pry'; binding.pry
  end

  def index
    @invoices = Invoice.all
  end
end