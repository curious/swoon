require 'virtus'

module Swoon
  module Requests
    class Recipient
      include Virtus.model
      attribute :name
      attribute :address
    end
  end
end
