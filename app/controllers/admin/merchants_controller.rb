class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @merchant_image = MerchantSearch.merchant_info(@merchant.name)
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)

    if @merchant.save
      @merchant.switch_enabled
      flash[:notice] = "#{@merchant.name} was successfully created"
      redirect_to admin_merchants_path
      
    else
      flash[:alert] = "You messed up. Try again"
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])

    if params[:switch_enabled]
      @merchant.switch_enabled
      enabled_text = @merchant.enabled ? "Enabled" : "Disabled"
      redirect_to admin_merchants_path, notice: "#{@merchant.name} is #{enabled_text}"

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