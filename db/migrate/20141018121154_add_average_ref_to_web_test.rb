class AddAverageRefToWebTest < ActiveRecord::Migration
  def change
    add_reference :web_tests, :average, index: true
  end
end
