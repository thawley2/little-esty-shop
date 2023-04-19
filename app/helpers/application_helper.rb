module ApplicationHelper
  def unsplash_app_logo_url
    response = HTTParty.get('https://api.unsplash.com/photos/pFqrYbhIAXs/?client_id=1cd3V-4rbtUVO3VE00Xus_BcKE95xqwK4sdttc4GFsY')
    json = JSON.parse(response.body)
    json['urls']['thumb']
  end
end
