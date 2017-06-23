json.array!(@schedules_builders) do |schedules_builder|
  json.extract! schedules_builder, :id
  json.url schedules_builder_url(schedules_builder, format: :json)
end
