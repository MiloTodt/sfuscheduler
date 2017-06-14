json.array!(@classtimes) do |classtime|
  json.extract! classtime, :id, :name, :start_time
  json.url classtime_url(classtime, format: :json)
end
