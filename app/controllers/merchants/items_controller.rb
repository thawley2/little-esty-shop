class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item_image = ItemSearch.item_info(@item.name)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end
  
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])

    if @item.update(item_params)
      if params[:commit] == 'Submit'
        flash[:success] = "#{@item.name} was successfully updated."
        redirect_to merchant_item_path(@merchant, @item)
      else
        redirect_to merchant_items_path(@merchant)
      end
    else
      # require 'pry'; binding.pry
      flash[:error] = "You messed up. Please try again"
      render :edit
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end
  
  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.items.create(item_params)
    redirect_to merchant_items_path(merchant)
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end