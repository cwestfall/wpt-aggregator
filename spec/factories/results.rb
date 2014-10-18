# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    url 'http://google.com'
    load_time 1
    ttfb 1
    bytes_out 1
    bytes_out_doc 1
    bytes_in 1
    bytes_in_doc 1
    requests 1
    requests_doc 1
    result 1
    render 1
    fully_loaded 1
    cached 1
    web 1
    doc_time 1
    dom_time 1
    score_cache 1
    score_cdn 1
    score_gzip 1
    score_cookies 1
    score_keep_alive 1
    score_minify 1
    score_combine 1
    score_compress 1
    score_etags 1
    dom_elements 21
    run_date '2014-10-09 15:40:01'
  end
end
