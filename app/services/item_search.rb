class ItemSearch
  
  def item_info(item_name)
    item = service.item_image(item_name)
    ItemImage.new(item)
  end

  def service
    UnsplashService.new
  end
end