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
      attr_accessor :intercept_to
      attr_accessor :intercept_cc
      attr_accessor :intercept_bcc

      def initialize
        api_key       = ENV["POSTMARK_API_KEY"] || "POSTMARK_API_TEST"
        secure        = ENV["POSTMARK_SECURE"] || true
        intercept_to  = ENV["THINCLOUD_INTERCEPT_TO"]
        intercept_cc  = ENV["THINCLOUD_INTERCEPT_CC"]
        intercept_bcc = ENV["THINCLOUD_INTERCEPT_BCC"]

        @api_key       ||= api_key
        @intercept_to  ||= intercept_to
        @intercept_cc  ||= intercept_cc
        @intercept_bcc ||= intercept_bcc

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
