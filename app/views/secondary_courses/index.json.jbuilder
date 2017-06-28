json.array!(@secondary_courses) do |secondary_course|
  json.extract! secondary_course, :id, :dept, :number, :section, :name, :description, :title, :designation, :course_details, :prerequisites, :units, :term, :delivery_method, :schedule
  json.url secondary_course_url(secondary_course, format: :json)
end
