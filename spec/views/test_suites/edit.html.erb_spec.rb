require 'rails_helper'

RSpec.describe "test_suites/edit", :type => :view do
  before(:each) do
    @test_suite = assign(:test_suite, TestSuite.create!(
      :label => "MyString"
    ))
  end

  it "renders the edit test_suite form" do
    render

    assert_select "form[action=?][method=?]", test_suite_path(@test_suite), "post" do

      assert_select "input#test_suite_label[name=?]", "test_suite[label]"
    end
  end
end
