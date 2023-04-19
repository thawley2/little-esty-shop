class ItemImage
  attr_reader :image_url
  
  def initialize(item_info)
    @image_url = item_info[:results].first[:urls][:thumb]
  end
end