class MerchantSearch
  
  def self.merchant_info(merchant_name)
    merchant = self.service.random_image(merchant_name)
    MerchantImage.new(merchant)
  end

  def self.service
    UnsplashService.new
  end
end