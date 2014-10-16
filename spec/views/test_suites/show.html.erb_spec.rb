require 'rails_helper'

RSpec.describe "test_suites/show", :type => :view do
  before(:each) do
    @test_suite = assign(:test_suite, TestSuite.create!(
      :label => "Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Label/)
  end
end
