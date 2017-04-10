require 'virtus'

module Swoon
  module Requests
    class SendRequest
      include Virtus.model
      attribute :template, String
      attribute :version_name, String
      attribute :variant, String
      attribute :template_data, Hash
      attribute :esp_account, String
      attribute :headers, Hash
      attribute :recipient, Recipient
      attribute :sender, Sender
      attribute :cc, Array[Recipient]
      attribute :bcc, Array[Recipient]
      attribute :tags, Array[String]
      attribute :locale, String
    end
  end
end
