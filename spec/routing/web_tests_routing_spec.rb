require 'rails_helper'

RSpec.describe WebTestsController, :type => :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/test_suites/1/web_tests').to route_to('web_tests#index', test_suite_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/test_suites/1/web_tests/new').to route_to('web_tests#new', test_suite_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/test_suites/1/web_tests/1').to route_to('web_tests#show', id: '1', test_suite_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/test_suites/1/web_tests/1/edit').to route_to('web_tests#edit', id: '1', test_suite_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/test_suites/1/web_tests').to route_to('web_tests#create', test_suite_id: '1')
    end

    it 'routes to #update' do
      expect(put: '/test_suites/1/web_tests/1').to route_to('web_tests#update', id: '1', test_suite_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/test_suites/1/web_tests/1').to route_to('web_tests#destroy', id: '1', test_suite_id: '1')
    end

  end
end
