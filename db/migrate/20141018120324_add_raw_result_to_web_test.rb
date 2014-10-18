class AddRawResultToWebTest < ActiveRecord::Migration
  def change
    add_column :web_tests, :raw_result, :text
  end
end
