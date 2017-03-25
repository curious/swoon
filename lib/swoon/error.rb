require 'swoon/version'
require 'rest-client'

module Swoon
  class Error < StandardError
    attr_reader :body, :status_code, :path, :method

    def initialize(message = '', params)
      @body = params[:body]
      @status_code = params[:status_code]
      @path = params[:path]
      @method = params[:method]
      super(message)
    end

    def to_s
      super + ' ' + instance_variables_to_s
    end

    private

    def instance_variables_to_s
      [:method, :path, :body, :status_code].map do |attr|
        attr_value = send(attr)

        "@#{attr}=#{attr_value.inspect}"
      end.join(', ')
    end
  end
end
