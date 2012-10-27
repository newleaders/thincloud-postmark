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

      # Apply the postmark settings just before ActionMailer applies them
      initializer "thincloud.postmark.action_mailer", after: "finisher_hook" do |app|
        if configuration.api_key
          app.config.action_mailer.delivery_method = :postmark
          app.config.action_mailer.postmark_settings = { api_key: configuration.api_key }
        end
      end

    end
  end
end