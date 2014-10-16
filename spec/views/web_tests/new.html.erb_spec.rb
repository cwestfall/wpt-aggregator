require 'rails_helper'

RSpec.describe "web_tests/new", :type => :view do
  before(:each) do
    assign(:web_test, WebTest.new(
      :url => "MyText",
      :label => "MyString",
      :requested_runs => 1,
      :location => "MyString",
      :additional_parameters => "MyText",
      :wpt_id => "MyString"
    ))
  end

  it "renders new web_test form" do
    skip()
    render

    assert_select "form[action=?][method=?]", web_tests_path, "post" do

      assert_select "textarea#web_test_url[name=?]", "web_test[url]"

      assert_select "input#web_test_label[name=?]", "web_test[label]"

      assert_select "input#web_test_requested_runs[name=?]", "web_test[requested_runs]"

      assert_select "input#web_test_location[name=?]", "web_test[location]"

      assert_select "textarea#web_test_additional_parameters[name=?]", "web_test[additional_parameters]"

      assert_select "input#web_test_status[name=?]", "web_test[status]"

      assert_select "input#web_test_wpt_id[name=?]", "web_test[wpt_id]"
    end
  end
end
