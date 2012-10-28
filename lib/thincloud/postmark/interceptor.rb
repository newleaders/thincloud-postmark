module Thincloud
  module Postmark
    # Public: Default Rails mail interceptor
    class Interceptor
      class << self
        attr_accessor :to
        attr_accessor :bcc
      end

      def self.delivering_email(message)
        message.subject = "#{message.to} #{message.subject}"
        message.to      = self.to
        message.bcc     = self.bcc
        message
      end
    end
  end
end