class CreateBuildSchedules < ActiveRecord::Migration
  def change
    create_table :build_schedules do |t|
      t.text :courses

      t.timestamps null: false
    end
  end
end
