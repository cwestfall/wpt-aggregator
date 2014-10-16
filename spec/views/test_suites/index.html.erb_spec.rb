require 'rails_helper'

RSpec.describe "test_suites/index", :type => :view do
  before(:each) do
    test_suite = create(:test_suite)
    assign(:test_suites, [test_suite, test_suite])
  end

  it "renders a list of test_suites" do
    render
    assert_select "tr>td", :text => 'My Test Suite Label'.to_s, :count => 2
  end
end
