json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :name, :street, :zip, :email, :phone, :url
  json.url supplier_url(supplier, format: :json)
end
