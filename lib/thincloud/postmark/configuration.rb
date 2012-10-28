module Thincloud
  module Postmark
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield configuration if block_given?
      configuration
    end

    # Public: Configuration options for the Thincloud::Postmark module
    class Configuration
      attr_accessor :api_key
      attr_accessor :interceptor_to
      attr_accessor :interceptor_cc
      attr_accessor :interceptor_bcc
      attr_accessor :interceptor_environments

      def initialize
        api_key         = ENV["POSTMARK_API_KEY"] || "POSTMARK_API_TEST"
        secure          = ENV["POSTMARK_SECURE"] || true
        interceptor_to  = ENV["THINCLOUD_INTERCEPTOR_TO"]
        interceptor_cc  = ENV["THINCLOUD_INTERCEPTOR_CC"]
        interceptor_bcc = ENV["THINCLOUD_INTERCEPTOR_BCC"]

        @api_key         ||= api_key
        @interceptor_to  ||= interceptor_to
        @interceptor_cc  ||= interceptor_cc
        @interceptor_bcc ||= interceptor_bcc

        @interceptor_environments = []
        self.secure = secure
      end

      def secure=(s)
        ::Postmark.secure = s
      end

      def secure
        ::Postmark.secure
      end
    end
  end
end
