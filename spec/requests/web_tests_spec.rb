require 'rails_helper'

RSpec.describe "WebTests", :type => :request do
  describe "GET /test_suites/1/web_tests" do

    it "works! (now write some real specs)" do
      skip('wait until UI is better defined')
      get test_suite_web_tests_path(test_suite_id: '1')
      expect(response).to have_http_status(200)
    end
  end
end
