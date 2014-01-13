json.array!(@requests) do |request|
  json.extract! request, :id, :subject, :body, :urgency, :customer_id, :agent_id, :note_id, :offer_id
  json.url request_url(request, format: :json)
end
