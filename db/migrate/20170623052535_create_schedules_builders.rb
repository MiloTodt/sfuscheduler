class CreateSchedulesBuilders < ActiveRecord::Migration
  def change
    create_table :schedules_builders do |t|
      t.string :classes

      t.timestamps null: false
    end
  end
end
