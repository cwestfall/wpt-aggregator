require 'spec_helper'

describe Webpagetest do
  # Local variables
  let(:key){ "your_api_key" }
  let(:test_url){ "http://todomvc.com/architecture-examples/emberjs/" }
  let(:script){ "some_encoded_script" }
  let(:test_id) { "131004_GT_3A0" }
  let(:wpt) { Webpagetest.new(k: key) }

  # Test case when establishing a connection (no requests yet)
  it 'should establish a connection with required params' do
    expect(wpt.connection).to be_truthy
    expect(wpt.connection).to be_instance_of(Faraday::Connection)
  end
   
  # Set of test cases when running a test
  it 'should run a test with parameters included' do
    run_test_request
    response = wpt.run_test do |params|
      params.url = test_url
      params.script = script
    end
    expect(response.test_id).to be_a(String)
    expect(response.raw).to be_instance_of(Hashie::Mash)
    expect(response.raw.statusCode).to be 200
    expect(response.test_id).to be_truthy
  end
 
  it 'should get the status of a test after being run' do
    run_test_request
    response = wpt.run_test do |params|
      params.url = test_url
      params.script = script
    end

    # Get status while test is running
    test_status_running_request
    status = response.get_status
    expect(status).to be(:running)
    expect(response.result).to be_falsey

    # Get status when test is completed
    test_status_completed_request
    test_result_request
    status = response.get_status
    expect(status).to be(:completed)
  end

  it 'should get the result of a test after its completion' do
    run_test_request
    response = wpt.run_test do |params|
      params.url = test_url
      params.script = script
    end
    test_status_completed_request
    test_result_request
    response.get_status
    expect(response.result).to be_truthy
    expect(response.result).to be_instance_of(Hashie::Mash)
    expect(response.result.runs[1].firstView.loadTime).to be_a(Fixnum)
  end

  # Set of test cases for retrieving a test result
  it 'should get the result of a running test using its id' do
    test_result_running_request
    response = wpt.test_result(test_id)
    expect(response.test_id).to be_a(String)

    status_test_result_running_request
    status = response.get_status
    expect(status).to be(:running)
    expect(response.result).to be_falsey

    status_test_result_completed_request
    other_test_result_request
    status = response.get_status
    expect(status).to be(:completed)
  end
  
  it 'should get the result of a completed test using its id' do
    other_test_result_request
    response = wpt.test_result(test_id)
    expect(response.test_id).to be_a(String)

    status_test_result_completed_request
    response.get_status
    expect(response.result).to be_truthy
    expect(response.result).to be_instance_of(Hashie::Mash)
    expect(response.result.runs[1].firstView.loadTime).to be_a(Fixnum)
  end

  # Test case for retrieving available locations
  it 'should get available locations' do
    locations_request
    locations = wpt.locations
    expect(locations).to be_instance_of(Hashie::Mash)
    expect(locations.values.first.Label).to be_truthy
  end

  # Set of test cases when Webpagetest API is not available
  it 'should get a service not available response after trying to run a test' do
    error_run_test_request
    response = wpt.run_test do |params|
      params.url = test_url
      params.script = script
    end
    expect(response.key?(:status_code)).to be true
    expect(response.status_code).to be_a(Fixnum)
    expect(response.status_code).not_to be 200
  end

  it 'should get a service not available response after trying to get a test result' do
    error_test_result_request
    response = wpt.test_result(test_id)
    expect(response.key?(:status_code)).to be true
    expect(response.status_code).to be_a(Fixnum)
    expect(response.status_code).not_to be 200
  end

  it 'should get a service not available response after trying to get locations' do
    error_locations_request
    locations = wpt.locations
    expect(locations.key?(:status_code)).to be true
    expect(locations.status_code).to be_a(Fixnum)
    expect(locations.status_code).not_to be 200
  end 
  
end