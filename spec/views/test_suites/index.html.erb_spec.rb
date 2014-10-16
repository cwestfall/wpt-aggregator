require 'rails_helper'

RSpec.describe "test_suites/index", :type => :view do
  before(:each) do
    assign(:test_suites, [
      TestSuite.create!(
        :label => "Label"
      ),
      TestSuite.create!(
        :label => "Label"
      )
    ])
  end

  it "renders a list of test_suites" do
    skip()
    render
    assert_select "tr>td", :text => "Label".to_s, :count => 2
  end
end
