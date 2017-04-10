require 'representable'

module Swoon
  module Representers
    class SendRequestRepresenter < Representable::Decorator
      include Representable::Hash

      property :template
      property :version_name
      property :variant
      property :template_data
      property :esp_account
      property :headers
      property :recipient, decorator: RecipientRepresenter, class: Swoon::Requests::Recipient
      property :sender, decorator: SenderRepresenter, class: Swoon::Requests::Sender
      collection :cc, decorator: RecipientRepresenter
      collection :bcc, decorator: RecipientRepresenter
      collection :tags
      property :locale
    end
  end
end
