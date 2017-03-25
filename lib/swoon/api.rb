module Swoon
  class API
    attr_reader :api_key

    def initialize(api_key:)
      @path_parts = []
      @api_key = api_key
    end

    def fetch(*args)
      params = args[0] if args[0]
      Request.new(builder: self).get(params)
    ensure
      reset
    end

    def create(*args)
      params = args[0] if args[0]
      Request.new(builder: self).post(params)
    ensure
      reset
    end

    def update(params)
      Request.new(builder: self).put(params)
    ensure
      reset
    end

    def delete
      Request.new(builder: self).delete
    ensure
      reset
    end

    def send(params)
      @path_parts << 'send'
      Request.new(builder: self).post(params)
    ensure
      reset
    end

    def batch(params)
      @path_parts << 'batch'
      response = Request.new(builder: self).post(params)
      response.each do |r|
        next if r[:status_code] == 200
        error_params = {
          body: r[:body],
          status_code: r[:status_code],
          path: '/batch',
          method: 'POST'
        }
        raise Error.new(r[:body], error_params)
      end
    ensure
      reset
    end

    def resend(params)
      @path_parts << 'resend'
      Request.new(builder: self).post(params)
    ensure
      reset
    end

    def render(params)
      @path_parts << 'render'
      Request.new(builder: self).post(params)
    ensure
      reset
    end

    def activate(params)
      @path_parts << 'activate'
      Request.new(builder: self).post(params)
    ensure
      reset
    end


    def deactivate(params)
      @path_parts << 'deactivate'
      Request.new(builder: self).post(params)
    ensure
      reset
    end

    def set_default(params)
      @path_parts << 'set_default'
      Request.new(builder: self).post(params)
    ensure
      reset
    end

    def path
      @path_parts.join('/')
    end

    def method_missing(method, *args, &block)
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
