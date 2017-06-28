class CreateSecondaryCourses < ActiveRecord::Migration
  def change
    create_table :secondary_courses do |t|
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
      t.string :delivery_method
      t.string :schedule

      t.timestamps null: false
    end
  end
end
