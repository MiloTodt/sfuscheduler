class AddPrimaryCourseIdToSecondaryCourse < ActiveRecord::Migration
  def change
    add_column :secondary_courses, :primary_course_id, :integer
  end
end
