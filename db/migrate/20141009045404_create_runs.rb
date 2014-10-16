class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.belongs_to :web_test, index: true
      t.integer :wpt_id
      t.references :first_view
      t.references :repeat_view

      t.timestamps
    end
  end
end
