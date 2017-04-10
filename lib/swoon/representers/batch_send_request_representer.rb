require 'representable'

module Swoon
  module Representers
    class BatchSendRequestRepresenter < Representable::Decorator
      include Representable::Hash
      property :path
      property :method
      property :body, decorator: SendRequestRepresenter
    end
  end
end
