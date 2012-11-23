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

      # Rails applies config.action_mailer to ActionMailer::Base before
      # initializers are run. This hooks into the end of the initialization
      # process to make sure we have our config settings then we apply them
      # to AM::Base. Keep them in both places so config appears normal.
      initializer "thincloud.postmark.settings", before: "finisher_hook" do
        # TODO: Find a way to check other environments in the tests. The dummy
        # application setup in Rails Engine testing only allows us to test one
        # environment, :test in this case.
        if configuration.environments.include?(Rails.env.to_sym)
          [ActionMailer::Base, config.action_mailer].each do |c|
            c.delivery_method   = :postmark
            c.postmark_settings = { api_key: configuration.api_key }
          end
        end
      end

    end
  end
end