module Thincloud
  module Postmark
    # Public: Default Rails mail interceptor
    class Interceptor
      class << self
        attr_accessor :to
        attr_accessor :cc
        attr_accessor :bcc
      end

      def self.delivering_email(message)
        message.subject = "[#{message.to}] #{message.subject}"
        message.to      = to
        message.cc      = cc
        message.bcc     = bcc
        message
      end
    end
  end
end
