class AddTestSuiteRefToWebTest < ActiveRecord::Migration
  def change
    add_reference :web_tests, :test_suite, index: true
  end
end
