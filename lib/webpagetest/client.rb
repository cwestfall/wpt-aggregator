require 'webpagetest/connection'

module Webpagetest
  class Client

    attr_reader :params, :connection, :response

    TEST_BASE = 'runtest.php'
    LOCATIONS_BASE = 'getLocations.php'
    RESULT_BASE = 'jsonResult.php'
    STATUS_BASE = 'testStatus.php'

    # Main params for running tests
    def initialize(params = {})
      params = Hashie::Mash.new(params)
      required_params params      
      params.f ||= :json
      params.options ||= nil
      @params = params
      @connection = get_connection params.options
    end

    # Alias method for API key
    def key
      params.k
    end

    # Runs a test bases on provided parameters
    def run_test
      # Make sure that params have been set
      raise_error('You need to pass some params to run the test. At least, an url or script') unless block_given?
      params = Hashie::Mash.new
      yield params
      raise_error('No params were passed to run_test method') if params.empty?

      response = connection.post do |req|
        req.url "#{TEST_BASE}"
        req.params['k'] = key
        req.params['f'] = @params.f
        params.each do |k, v|
          req.params[k] = v
        end
      end
      return not_available (response) unless response.status == 200
      @response = Response.new(Hashie::Mash.new(JSON.parse(response.body)))
    end

    # Gets the status of a test based on its id
    # def check_test_status(test_id)
    #   test_params = Hashie::Mash.new( {test: test_id, f: :json} )
    #   response = make_request(STATUS_BASE, test_params)
    #   @response = Response.new(Hashie::Mash.new(JSON.parse(response.body)))
    #
    #   # Check 3 possible scenarios
    #   case @response.data.statusCode.to_s
    #     when /1../
    #       @status = :running
    #     when "200"
    #       @status = :completed
    #       fetch_result
    #     else
    #       @current_status = :error
    #   end
    #
    # end

    # Gets the result of a test based on its id
    def test_result(test_id)
      test_params = Hashie::Mash.new( {test: test_id, pagespeed: 1} )
      response = make_request(RESULT_BASE, test_params)
      return not_available (response) unless response.status == 200
      @response = Response.new(Hashie::Mash.new(JSON.parse(response.body)), false)
    end

    # Gets all available test locations
    def locations
      locations_params = Hashie::Mash.new( {f: params.f} )
      response = make_request(LOCATIONS_BASE, locations_params)
      return not_available (response) unless response.status == 200
      response_body = Hashie::Mash.new(JSON.parse(response.body))  
      response_body.data
    end

    private

    include Connection

    # Makes a simple request with params
    def make_request(url, params)
      connection.get do |req|
        req.url url
        params.each do |k, v|
          req.params[k] = v
        end        
      end
    end

    # Check required parameters to initialize Webpagetest
    def required_params(params)
      raise_error("An API key must be specified using :k variable name") if not params.key?(:k)
    end

    # Returns a hashie hash with no available information
    def not_available(response)
      Hashie::Mash.new( {
        status_code: response.status,
        status_text: 'Service not available'
      } )
    end

    # Wrapper for raising errors with custom messages
    def raise_error(msg)
      raise Error.new(msg)
    end

  end
end