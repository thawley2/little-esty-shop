class BulkDiscountsController < ApplicationController
before_action :find_discount

  def show
  end

  def edit
  end

  def find_discount
    @discount = BulkDiscount.find(params[:id])
  end
end