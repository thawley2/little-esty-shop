class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end
  
  def update
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:id])

    if @item.update(item_params)
      flash[:success] = "#{@item.name} was successfully updated."
      redirect_to merchant_item_path(@merchant, @item)
    else
      flash[:error] = "You messed up. Please try again"
      render :edit
    end
  end
end