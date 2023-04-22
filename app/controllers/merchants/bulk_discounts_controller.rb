class Merchants::BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    new = merchant.bulk_discounts.new(bulk_discount_params)
    if new.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      flash[:error] = 'Please fill out all required fields'
      render :new
    end 
  end

  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :percent_discount, :quantity_threshold)
  end
end