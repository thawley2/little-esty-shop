class ItemSearch
  
  def self.item_info(item_name)
    item = self.service.item_image(item_name)
    ItemImage.new(item)
  end

  def self.service
    UnsplashService.new
  end
end