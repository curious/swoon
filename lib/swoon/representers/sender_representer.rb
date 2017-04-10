require 'representable'

module Swoon
  module Representers
    class SenderRepresenter < Representable::Decorator
      include Representable::Hash

      property :name
      property :address
      property :reply_to
    end
  end
end
