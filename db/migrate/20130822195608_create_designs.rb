class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.integer :designId
      t.string :metricId
      t.string :productName
      t.string :consumerName
      t.datetime :timestamp
      t.string :status

      t.timestamps
    end
  end
end
