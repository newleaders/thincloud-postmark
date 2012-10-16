module Thincloud
  module Postmark
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield configuration
    end

    # Public: Configuration options for the Thincloud::Postmark module
    class Configuration
      attr_accessor :api_key

      def initialize
        @api_key = "POSTMARK_API_TEST"
      end
    end
  end
end
