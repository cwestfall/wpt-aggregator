# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :web_test, aliases: [:first_view, :repeat_view] do
    association :test_suite, factory: :test_suite
    url 'http://www.google.com'
    label 'The Label'
    requested_runs 3
    location 'Colorado:Chrome'
    additional_parameters 'comma=seperated,list=of,keys_and=values'
    wpt_id '141013_KT_1113'
    raw_result 'Some JSON result'
  end
end
