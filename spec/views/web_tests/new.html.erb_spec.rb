require 'rails_helper'

RSpec.describe "web_tests/new", :type => :view do
  before(:each) do
    web_test = create(:web_test)
    @web_test = assign(:web_test, web_test)
    @test_suite = assign(:test_suite, web_test.test_suite)
  end

  it "renders new web_test form" do
    render

    assert_select "form[action=?][method=?]", test_suite_web_test_path(@test_suite, @web_test), "post" do

      assert_select "textarea#web_test_url[name=?]", "web_test[url]"

      assert_select "input#web_test_label[name=?]", "web_test[label]"

      assert_select "input#web_test_requested_runs[name=?]", "web_test[requested_runs]"

      assert_select "input#web_test_location[name=?]", "web_test[location]"

      assert_select "textarea#web_test_additional_parameters[name=?]", "web_test[additional_parameters]"

    end
  end
end
