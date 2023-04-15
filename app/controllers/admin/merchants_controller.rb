class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])

    if params[:switch_enabled]
      @merchant.switch_enabled
      redirect_to admin_merchants_path, notice: "#{@merchant.name} is #{@merchant.enabled? ? 'Enabled': 'Disabled'}"


    elsif @merchant.update(merchant_params)
      flash[:success] = "#{@merchant.name} was successfully updated."
      redirect_to admin_merchant_path(@merchant)

    else
      flash[:error] = "Error updating merchant. Please try again."
      render :edit
    end
  end

 
 

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end