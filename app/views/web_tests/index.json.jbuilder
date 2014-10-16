json.array!(@web_tests) do |web_test|
  json.extract! web_test, :id, :url, :label, :requested_runs, :location, :additional_parameters, :status, :wpt_id
  json.url web_test_url(web_test, format: :json)
end
