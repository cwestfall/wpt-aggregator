require 'rails_helper'

RSpec.describe "web_tests/show", :type => :view do
  before(:each) do
    @web_test = assign(:web_test, create(:web_test))
  end

  it "renders attributes in <p>" do
    skip()
    render
    expect(rendered).to match(/http:\/\/www.google.com/)
    expect(rendered).to match(/The Label/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Colorado:Chrome/)
    expect(rendered).to match(/comma=seperated,list=of,keys_and=values/)
    expect(rendered).to match(/running/)
    expect(rendered).to match(/SOME_WPT_ID_001/)
  end
end
