class Engine < ::Rails::Engine

  # Require the config initializer in advance so it is available for
  # the "thincloud.postmark.action_mailer" initializer
  initializer "thincloud.postmark.configuration", before: "thincloud.postmark.action_mailer" do
    config_initializer = File.expand_path("config/initializers/thincloud_postmark.rb")
    require config_initializer if File.exists?(config_initializer)
  end

  # Apply the postmark settings just before ActionMailer applies them
  initializer "thincloud.postmark.action_mailer", before: "action_mailer.set_configs" do
    if api_key = Thincloud::Postmark.configuration.try(:api_key)
      Postmark.secure = true
      Rails.application.config.action_mailer.delivery_method = :postmark
      Rails.application.config.action_mailer.postmark_settings = { api_key: api_key }
    end
  end

end
