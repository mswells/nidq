json.array!(@designs) do |design|
  json.extract! design, :id, :designId, :metricId, :productName, :consumerName, :timestamp, :status
  json.url design_url(design, format: :json)
end
