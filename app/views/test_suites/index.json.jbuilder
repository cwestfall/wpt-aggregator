json.array!(@test_suites) do |test_suite|
  json.extract! test_suite, :id, :label
  json.url test_suite_url(test_suite, format: :json)
end
