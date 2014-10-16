require 'rails_helper'

RSpec.describe "TestSuites", :type => :request do
  describe "GET /test_suites" do
    it "works! (now write some real specs)" do
      get test_suites_path
      expect(response).to have_http_status(200)
    end
  end
end
