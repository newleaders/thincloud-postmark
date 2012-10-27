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
      attr_accessor :api_key,
                    :secure

      def initialize
        api_key = ENV["POSTMARK_API_KEY"] || "POSTMARK_API_TEST"
        secure  = ENV["POSTMARK_SECURE"] || true

        @api_key ||= api_key
        @secure  ||= secure
      end
    end
  end
end
