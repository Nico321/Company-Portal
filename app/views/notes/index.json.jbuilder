json.array!(@notes) do |note|
  json.extract! note, :id, :subject, :body, :stateid, :imageurl, :businessprocessid
  json.url note_url(note, format: :json)
end
