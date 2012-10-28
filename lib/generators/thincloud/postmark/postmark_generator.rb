require "rails"

module Thincloud
  module Generators
    # Public: Rails generator to add additional postmark infrastructure
    class PostmarkGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates Postmark configuration for Rails app"

      def postmark

        gem "postmark-rails", "~> 0.4.1"

        copy_file "action_mailer.rb", "config/initializers/action_mailer.rb"

        copy_file "thincloud_postmark.rb",
                  "config/initializers/thincloud_postmark.rb"

        copy_file "mail_interceptor.rb", "lib/mail_interceptor.rb"

        say_status "", ""
        say_status "success", "Initial Postmark configuration has been created"
        say_status "", "Don't forget to run `bundle`"
        say_status "", ""
        say_status "", "In application.rb, add:"

        default_url = " config.action_mailer.default_url_options ="
        default_url << %[ { host: "mydomain.com" } ]

        say_status "", default_url
        say_status "", "In lib/mail_interceptor.rb:"
        say_status "", "Set email address to your own pattern "

      end
    end
  end
end
