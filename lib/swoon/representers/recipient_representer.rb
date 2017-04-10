require 'representable'

module Swoon
  module Representers
    class RecipientRepresenter < Representable::Decorator
      include Representable::Hash

      property :name
      property :address
    end
  end
end
