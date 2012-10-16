class Engine < ::Rails::Engine

  # Require the config initializer in advance so it is available for
  # the "thincloud.postmark.action_mailer" initializer
  initializer "thincloud.postmark.configuration", before: "thincloud.postmark.action_mailer" do
    require File.expand_path("config/initializers/thincloud_postmark")
  end

  # Apply the postmark settings just before ActionMailer applies them
  initializer "thincloud.postmark.action_mailer", before: "action_mailer.set_configs" do
    Postmark.secure = true
    Rails.application.config.action_mailer.delivery_method = :postmark
    Rails.application.config.action_mailer.postmark_settings = {
      api_key: Thincloud::Postmark.configuration.api_key
    }
  end

end
