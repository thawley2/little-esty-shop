class MerchantImage
  attr_reader :image_url
  
  def initialize(merch_info)
    @image_url = merch_info[:results].first[:urls][:thumb]
  end
end