require 'rails_helper'

RSpec.describe "web_tests/index", :type => :view do
  before(:each) do
    assign(:web_tests, [
      create(:web_test),
      create(:web_test)
    ])
  end

  it "renders a list of web_tests" do
    skip('need to update view')
    render
    assert_select "tr>td", :text => 'http://www.google.com'.to_s, :count => 2
    assert_select "tr>td", :text => 'The Label'.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 'Colorado:Chrome'.to_s, :count => 2
    assert_select "tr>td", :text => 'comma=seperated,list=of,keys_and=values'.to_s, :count => 2
    assert_select "tr>td", :text => :running.to_s, :count => 2
    assert_select "tr>td", :text => 'SOME_WPT_ID_001'.to_s, :count => 2
  end
end
