class LogoImage
  attr_reader :image_url,
              :likes

  def initialize(data)
    @image_url = data[:urls][:thumb]
    @likes = data[:likes]
  end
end