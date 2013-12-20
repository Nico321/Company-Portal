json.array!(@bugreports) do |bugreport|
  json.extract! bugreport, :id, :subject, :description, :userid, :employeeid
  json.url bugreport_url(bugreport, format: :json)
end
