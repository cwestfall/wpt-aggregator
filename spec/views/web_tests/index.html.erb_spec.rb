require 'rails_helper'

RSpec.describe "web_tests/index", :type => :view do
  before(:each) do
    web_test = create(:web_test)

    assign(:web_tests, [web_test, web_test])
    assign(:test_suite, web_test.test_suite)
  end

  it "renders a list of web_tests" do
    render
    assert_select "tr>td", :text => 'http://www.google.com'.to_s, :count => 2
    assert_select "tr>td", :text => 'The Label'.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 'Colorado:Chrome'.to_s, :count => 2
    assert_select "tr>td", :text => 'comma=seperated,list=of,keys_and=values'.to_s, :count => 2
    assert_select "tr>td", :text => 'pending', :count => 2
    assert_select "tr>td", :text => '141013_KT_1113'.to_s, :count => 2
  end
end
