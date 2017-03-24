require 'swoon/version'
require 'rest-client'

module Swoon
  class APIRequest
    def initialize(builder:)
      @request_builder = builder
      RestClient.log = Logger.new(STDOUT)
    end

    def get(params)
      RestClient.get api_url,
                     params: params,
                     x_swu_api_key: @request_builder.api_key,
                     x_swu_api_client: 'swoon 0.1.0',
                     accept: 'application/json',
                     content_type: 'application/json'
    end

    def post(params)
      RestClient.post api_url, params.to_json, headers
    end

    def put(params)
      RestClient.put api_url, params.to_json, headers
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

  class API
    attr_reader :api_key, :debugger

    def initialize(api_key:, debug: false)
      @path_parts = []
      @api_key = api_key
      @debug = debug
    end

    def retrieve(*args)
      params = args[0] if args[0]
      APIRequest.new(builder: self).get(params)
    ensure
      reset
    end

    def send(params)
      @path_parts << 'send'
      APIRequest.new(builder: self).post(params)
    ensure
      reset
    end

    def batch(params)
      @path_parts << 'batch'
      APIRequest.new(builder: self).post(params)
    ensure
      reset
    end

    def create(params)
      APIRequest.new(builder: self).post(params)
    ensure
      reset
    end

    def update(params)
      APIRequest.new(builder: self).put(params)
    ensure
      reset
    end

    def path
      @path_parts.join('/')
    end

    def method_missing(method, *args)
      @path_parts << method.to_s unless method == :emails
      @path_parts << args if args.length > 0
      @path_parts.flatten!
      self
    end

    protected

    def reset
      @path_parts = []
    end
  end
end
