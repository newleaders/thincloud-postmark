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

      def initialize
        api_key = ENV["POSTMARK_API_KEY"] || "POSTMARK_API_TEST"

        @api_key ||= api_key

        self.secure  = ENV["POSTMARK_SECURE"] || true
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
