module Thincloud
  module Postmark
    # Public: Thincloud Postmark Engine
    class Engine < ::Rails::Engine

      # convenience method for engine options / configuration
      def configuration
        Thincloud::Postmark.configuration
      end

      # initialize the configuration so it is available during rails init
      ActiveSupport.on_load :before_configuration do
        unless config.respond_to? :thincloud
          config.thincloud = ActiveSupport::OrderedOptions.new
        end

        config.thincloud.postmark ||= Thincloud::Postmark.configure
      end

      # Require the config initializer in advance so it is available for
      # the "thincloud.postmark.action_mailer" initializer
      initializer "thincloud.postmark.configuration", before: "thincloud.postmark.action_mailer" do
        config_initializer = File.expand_path("config/initializers/thincloud_postmark.rb")
        require config_initializer if File.exists?(config_initializer)
      end

      # Apply the postmark settings just before ActionMailer applies them
      initializer "thincloud.postmark.action_mailer", before: "action_mailer.set_configs" do
        if configuration.api_key
          ::Postmark.secure = true
          Rails.application.config.action_mailer.delivery_method = :postmark
          Rails.application.config.action_mailer.postmark_settings = { api_key: configuration.api_key }
        end
      end

    end
  end
end