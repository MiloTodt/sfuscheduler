class CreateScheduleBuilders < ActiveRecord::Migration
  def change
    create_table :schedule_builders do |t|

      t.timestamps null: false
    end
  end
end
