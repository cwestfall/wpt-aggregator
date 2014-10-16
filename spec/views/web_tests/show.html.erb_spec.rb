require 'rails_helper'

RSpec.describe "web_tests/show", :type => :view do
  before(:each) do
    @web_test = assign(:web_test, create(:web_test))
    @test_suite = assign(:test_suite, @web_test.test_suite)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/http:\/\/www.google.com/)
    expect(rendered).to match(/The Label/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Colorado:Chrome/)
    expect(rendered).to match(/comma=seperated,list=of,keys_and=values/)
    expect(rendered).to match(/pending/)
    expect(rendered).to match(/141013_KT_1113/)
  end
end
