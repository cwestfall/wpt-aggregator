class CreateWebTests < ActiveRecord::Migration
  def change
    create_table :web_tests do |t|
      t.text :url
      t.string :label
      t.integer :requested_runs
      t.string :location
      t.text :additional_parameters
      t.integer :status, default: 0
      t.string :wpt_id

      t.timestamps
    end
  end
end
