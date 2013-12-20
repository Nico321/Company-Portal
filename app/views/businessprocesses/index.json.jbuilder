json.array!(@businessprocesses) do |businessprocess|
  json.extract! businessprocess, :id, :customerid, :subject, :request, :employeeid, :urgency, :stateid, :discount, :offer, :installationprice
  json.url businessprocess_url(businessprocess, format: :json)
end
