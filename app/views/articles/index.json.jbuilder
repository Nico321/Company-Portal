json.array!(@articles) do |article|
  json.extract! article, :id, :name, :image, :price, :delivertime, :supplierid
  json.url article_url(article, format: :json)
end
