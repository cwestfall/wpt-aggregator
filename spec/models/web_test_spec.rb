require 'rails_helper'

RSpec.describe WebTest, :type => :model do
  it 'has a valid factory' do
    expect(create(:web_test)).to be_valid
  end

  it 'is invalid without a url' do
    expect(build(:web_test, url: nil)).not_to be_valid
  end

  it 'is invalid without a well formatted url' do
    expect(build(:web_test, url: 'not_a_url')).not_to be_valid
  end

  it 'should have default status of :pending upon creation' do
    web_test = create(:web_test)
    expect(web_test.status).to eq 'pending'
  end

  it 'should have many Runs' do
    web_test = create(:web_test)
    expect(web_test).to have_many(:run)
  end

  it 'should belong to TestSuite' do
    web_test = create(:web_test)
    expect(web_test).to belong_to(:test_suite)
  end

  describe 'when the execute method is called' do
    describe 'and the test is in a pending state' do
      it 'the wpt_id (unique test id) should be set' do
        submit_test_stub
        web_test = create(:web_test)
        web_test.execute

        expect(web_test.wpt_id).to eq '141013_KT_1113'
      end

      it 'the status should be set to running' do
        submit_test_stub
        web_test = create(:web_test)
        web_test.execute

        expect(web_test.status).to eq 'running'
      end

      it 'should set the status to error if the service returns an error' do
        skip('Implement error handling for Webpagetest requests')
        submit_test_stub
        error_stub

        web_test = create(:web_test)
        web_test.execute

        expect(web_test.status).to eq 'error'
      end

    end

    describe 'and the test is in a running state' do

      let(:web_test) {
        # Ensure status is pending before attempting to execute
        web_test = create(:web_test)
        web_test.running!
        web_test
      }

      it 'the status should remain in a running state if the test has not been completed' do
        test_result_still_running_stub
        test_status_running_stub
        web_test.execute
        expect(web_test.status).to eq 'running'
      end

      it 'should update the status when the service has completed the test' do
        test_result_stub
        test_status_complete_stub
        web_test.execute
        expect(web_test.status).to eq 'complete'
      end

      it 'should create both run and result objects' do
        test_result_stub
        test_status_complete_stub
        web_test.execute
        expect(web_test.run.size).to eq 3
        web_test.run.each do |run|
          expect(run.first_view).to be_instance_of(Result)
          expect(run.repeat_view).to be_instance_of(Result)
        end
      end
    end
  end

  private



end
