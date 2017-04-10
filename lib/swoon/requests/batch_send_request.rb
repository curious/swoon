require 'virtus'

module Swoon
  module Requests
    class BatchSendRequest
      include Virtus.model
      attribute :path, String, default: '/api/v1/send'
      attribute :method, String, default: 'POST'
      attribute :body, SendRequest
    end
  end
end
