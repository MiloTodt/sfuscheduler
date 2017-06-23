json.array!(@build_schedules) do |build_schedule|
  json.extract! build_schedule, :id, :courses
  json.url build_schedule_url(build_schedule, format: :json)
end
