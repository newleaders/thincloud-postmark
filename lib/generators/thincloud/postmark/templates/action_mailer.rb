require "mail_interceptor"
Mail.register_interceptor(MailInterceptor) unless Rails.env.production?
