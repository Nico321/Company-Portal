json.array!(@orders) do |order|
  json.extract! order, :id, :subject, :body, :installationprice, :customer_id, :agent_id, :installation_id
  json.url order_url(order, format: :json)
end
