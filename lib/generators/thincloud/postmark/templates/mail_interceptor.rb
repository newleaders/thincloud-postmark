# Public: Mail Interceptor to use when overriding defaults
class MailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to      = "#{ENV["USER"]}@localhost"
    message.cc      = nil
    message.bcc     = nil
  end
end
