class CreateDataBases < ActiveRecord::Migration
  def change
    create_table :data_bases do |t|

      t.timestamps null: false
    end
  end
end
