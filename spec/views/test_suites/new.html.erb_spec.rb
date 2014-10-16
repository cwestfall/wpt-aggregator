require 'rails_helper'

RSpec.describe "test_suites/new", :type => :view do
  before(:each) do
    assign(:test_suite, TestSuite.new(
      :label => "MyString"
    ))
  end

  it "renders new test_suite form" do
    render

    assert_select "form[action=?][method=?]", test_suites_path, "post" do

      assert_select "input#test_suite_label[name=?]", "test_suite[label]"
    end
  end
end
