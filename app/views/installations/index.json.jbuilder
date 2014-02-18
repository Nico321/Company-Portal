json.array!(@installations) do |installation|
  json.extract! installation, :id, :subject, :body, :installationdate, :invoice_id, :order_id
  json.url installation_url(installation, format: :json)
end
