class UnsplashService
  def random_image(name)
    get_url("https://api.unsplash.com/search/photos/?client_id=fZLFtH4Rwo9htDmPF2_l0LThWf8p-Z2qb8cxAKE8-q8&query=#{name}&per_page=1")
  end

  def project_logo
    get_url("")
  end

  def get_url(url)
    response = HTTParty.get(url)
    parsed_image = JSON.parse(response.body, symbolize_names: true)
  end
end
