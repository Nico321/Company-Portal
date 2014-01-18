json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :subject, :body, :installationprice
  json.url assignment_url(assignment, format: :json)
end
