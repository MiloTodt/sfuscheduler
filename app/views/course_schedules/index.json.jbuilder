json.array!(@course_schedules) do |course_schedule|
  json.extract! course_schedule, :id, :name
  json.url course_schedule_url(course_schedule, format: :json)
end
