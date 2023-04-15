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
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])

    if item.update(item_params)
      if params[:commit] == 'Submit'
        flash[:success] = "#{item.name} was successfully updated."
        redirect_to merchant_item_path(merchant, item)
      else
        redirect_to merchant_items_path(merchant)
      end
    else
      flash[:error] = "You messed up. Please try again"
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end