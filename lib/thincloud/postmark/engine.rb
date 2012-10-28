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

      initializer "thincloud.postmark.interceptor", after: "finisher_hook" do
        interceptor = Thincloud::Postmark::Interceptor.tap do |i|
          i.to  = configuration.interceptor_to
          i.cc  = configuration.interceptor_cc
          i.bcc = configuration.interceptor_bcc
        end

        if configuration.interceptor_environments.include?(Rails.env.to_sym)
          ::Mail.register_interceptor(interceptor)
        end
      end

      # Apply the postmark settings just before ActionMailer applies them
      initializer "thincloud.postmark.settings", after: "finisher_hook" do |app|
        if configuration.api_key
          postmark_settings = { api_key: configuration.api_key }

          config.action_mailer.delivery_method = :postmark
          config.action_mailer.postmark_settings = postmark_settings
        end
      end

    end
  end
end