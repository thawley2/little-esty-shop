class BulkDiscountsController < ApplicationController
  
  def show
    @discount = BulkDiscount.find(params[:id])
  end
end