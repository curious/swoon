require 'virtus'

module Swoon
  module Requests
    class Sender
      include Virtus.model
      attribute :name, String
      attribute :address, String
      attribute :reply_to, String
    end
  end
end
