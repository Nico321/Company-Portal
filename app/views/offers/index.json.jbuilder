json.array!(@offers) do |offer|
  json.extract! offer, :id, :subject, :body, :installationprice, :publication
  json.url offer_url(offer, format: :json)
end
