require 'multi_json'

module Swoon
  class Request
    def initialize(builder:)
      @request_builder = builder
      RestClient.log = Logger.new(STDOUT)
    end

    def get(params)
      response = RestClient.get api_url,
                                params: params,
                                x_swu_api_key: @request_builder.api_key,
                                x_swu_api_client: 'swoon 0.1.0',
                                accept: 'application/json',
                                content_type: 'application/json'

      MultiJson.load(response.body, symbolize_keys: true)

    rescue => e
      handle_error(e, @request_builder.path, 'GET')
    end

    def post(params)
      response = RestClient.post api_url, MultiJson.dump(params), headers
      MultiJson.load(response.body, symbolize_keys: true)
    rescue => e
      handle_error(e, @request_builder.path, 'POST')
    end

    def put(params)
      response = RestClient.put api_url, MultiJson.dump(params), headers
      MultiJson.load(response.body, symbolize_keys: true)
    rescue => e
      handle_error(e, @request_builder.path, 'PUT')
    end

    def delete
      RestClient.delete api_url,
                     x_swu_api_key: @request_builder.api_key,
                     x_swu_api_client: 'swoon 0.1.0',
                     accept: 'application/json',
                     content_type: 'application/json'

    rescue => e
      handle_error(e, @request_builder.path, 'DELETE')
    end

    def handle_error(error, path, http_method)
      raise error unless error.respond_to?(:response) && error.respond_to?(:http_code)
      error_params = {
        body: error.response,
        status_code: error.http_code,
        path: "/#{path}",
        method: http_method
      }
      error_to_raise = Error.new(error.message, error_params)
      raise error_to_raise
    end

    def base_url
      'https://api.sendwithus.com/api/v1/'
    end

    def api_url
      base_url + @request_builder.path
    end

    def api_key
      @request_builder.api_key
    end

    def headers
      {
        x_swu_api_key: @request_builder.api_key,
        x_swu_api_client: 'swoon 0.1.0',
        accept: 'application/json',
        content_type: 'application/json'
      }
    end
  end
end
