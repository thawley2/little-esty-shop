class BulkDiscountsController < ApplicationController
before_action :find_discount

  def show
  end

  def edit
  end

  def update
    if @discount.update(bulk_discount_params)
      redirect_to bulk_discount_path(@discount)
    else
      flash[:error] = 'Please do not leave any fields blank'
      render :edit
    end
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :percent_discount, :quantity_threshold)
  end

  def find_discount
    @discount = BulkDiscount.find(params[:id])
  end
end