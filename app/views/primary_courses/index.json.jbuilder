json.array!(@primary_courses) do |primary_course|
  json.extract! primary_course, :id, :dept, :number, :section, :name, :description, :title, :designation, :course_details, :prerequisites, :units, :term, :instructor_name, :instructor_email, :short_note, :delivery_method, :schedule
  json.url primary_course_url(primary_course, format: :json)
end
