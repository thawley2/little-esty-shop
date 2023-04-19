class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @merchant_image = MerchantSearch.merchant_info(@merchant.name)
  end
end