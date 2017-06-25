class CreateCourseSchedules < ActiveRecord::Migration
  def change
    create_table :course_schedules do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
