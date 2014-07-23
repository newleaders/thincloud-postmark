module Thincloud
  # Public: Postmark configuration namespace for Thincloud applications
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
      attr_accessor :environments
      attr_accessor :api_key
      attr_accessor :interceptor_to
      attr_accessor :interceptor_cc
      attr_accessor :interceptor_bcc
      attr_accessor :interceptor_environments

      def initialize
        @api_key ||= ENV.fetch("POSTMARK_API_KEY", "POSTMARK_API_TEST")

        @interceptor_to  ||= ENV["THINCLOUD_INTERCEPTOR_TO"]
        @interceptor_cc  ||= ENV["THINCLOUD_INTERCEPTOR_CC"]
        @interceptor_bcc ||= ENV["THINCLOUD_INTERCEPTOR_BCC"]

        @environments = []
        @interceptor_environments = []

        self.secure = ENV.fetch("POSTMARK_SECURE", true)
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
