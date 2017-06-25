class CreateSfucourses < ActiveRecord::Migration
  def change
    create_table :sfucourses do |t|
      t.text :name
      t.text :times
      t.text :campus

      t.timestamps null: false
    end
  end
end
