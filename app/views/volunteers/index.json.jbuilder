json.array!(@volunteers) do |volunteer|
  json.extract! volunteer, :id, :name
  json.url volunteer_url(volunteer, format: :json)
end
