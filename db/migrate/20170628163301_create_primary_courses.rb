class CreatePrimaryCourses < ActiveRecord::Migration
  def change
    create_table :primary_courses do |t|
      t.string :dept
      t.string :number
      t.string :section
      t.string :name
      t.string :description
      t.string :title
      t.string :designation
      t.text :course_details
      t.string :prerequisites
      t.string :units
      t.string :term
      t.string :instructor_name
      t.string :instructor_email
      t.string :short_note
      t.string :delivery_method
      t.string :schedule

      t.timestamps null: false
    end
  end
end
