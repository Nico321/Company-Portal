json.array!(@positions) do |position|
  json.extract! position, :id, :quantity, :deliverydate
  json.url position_url(position, format: :json)
end
