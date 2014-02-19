json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :subject, :body, :installation_id, :agent_id, :customer_id, :installationprice
  json.url invoice_url(invoice, format: :json)
end
