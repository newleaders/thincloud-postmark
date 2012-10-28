# Thincloud::Postmark

## Description

Rails Engine to provide [Postmark](http://postmarkapp.com) configuration for Thincloud applications.

The Thincloud::Postmark engine:

* Manages all of the `Postmark` dependencies for your application
* Optionally registers a `Mail` interceptor

## Requirements

This gem requires Rails 3.2+ and has been tested on the following versions:

* 3.2

This gem has been tested against the following Ruby versions:

* 1.9.3


## Installation

Add this line to your application's Gemfile:

``` ruby
gem "thincloud-postmark"
```

* Run `bundle`

Or install it yourself as:

```
$ gem install thincloud-postmark
```

## Usage

### Configuration

Thincloud::Postmark configuration options are available to customize the engine behavior. Available options and their default values:

```ruby
api_key                   = "POSTMARK_API_TEST"
interceptor_to            = nil
interceptor_cc            = nil
interceptor_bcc           = nil

# Rails environment(s) as a symbol that should have mail intercepted
interceptor_environments  = []
```

_Note: Don't forget to set the `default_url_options`_

```ruby
config.action_mailer.default_url_options = { host: "mydomain.com" }
```

#### Environment Variables

Several of the options will use environment variables when found.

```
api_key         -> ENV["POSTMARK_API_KEY"]
secure          -> ENV["POSTMARK_SECURE"]
interceptor_to  -> ENV["THINCLOUD_INTERCEPTOR_TO"]
interceptor_cc  -> ENV["THINCLOUD_INTERCEPTOR_CC"]
interceptor_bcc -> ENV["THINCLOUD_INTERCEPTOR_BCC"]
```

#### Configuration Block

The `Thincloud::Postmark` module accepts a `configure` block that takes the same options listed above. This block can be put into an initializer or inside of a `config\environments` file.

```ruby
Thincloud::Postmark do |config|
  config.api_key        = "MY_API_KEY"
  config.secure         = true
  config.interceptor_to = "keymaster@zuul.com"
  config.interceptor_cc = "gatekeeper@zuul.com"
  config.interceptor_environments = [:test, :development]
  # ...
end
```

#### Rails Configuration

You can also access the configuration via the Rails configuration object. In fact, the engine uses the Rails config as storage when the block syntax is used. The `Thincloud::Postmark::Configuration` object is made available under `config.thincloud.postmark`. You can access this configuration in `config/application.rb` or in your `config/environments` files.

```ruby
#...
config.thincloud.postmark.api_key = "MY_API_KEY"
config.thincloud.postmark.secure  = false
config.thincloud.postmark.interceptor_environments = [:staging]
#...
```

_Note: Configuration values take precendence over environment variables._

#### Default Interceptor

The default interceptor is registered for environments included in the `interceptor_environments` array. It replaces the recipients with those contained in the configuration and replaces the subject of outgoing email with the original `to` combined with the original `subject`.

```ruby
class Thincloud::Postmark::Interceptor
  # ...
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to      = self.to
    message.cc      = self.cc
    message.bcc     = self.bcc
    message
  end
end
```

#### Overriding the Interceptor

You may find that the default Interceptor does not meet your requirements. In that case you can easily create your own and prevent the default from being registered.

* Disable the default interceptor

```ruby
interceptor_environments = []
```

* Create your interceptor

```ruby
# Public: Mail Interceptor to use when overriding defaults
class MailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to      = "#{ENV["USER"]}@localhost"
    message.cc      = nil
    message.bcc     = nil
  end
end
```

* Register your interceptor in an initializer

```ruby
require "mail_interceptor"

Mail.register_interceptor(MailInterceptor) unless Rails.env.production?
```

## Contributing

1. [Fork it](https://github.com/newleaders/thincloud-postmark/fork_select)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. [Create a Pull Request](https://github.com/newleaders/thincloud-postmark/pull/new)


## License

* Freely distributable and licensed under the [MIT license](http://newleaders.mit-license.org/2012/license.html).
* Copyright (c) 2012 New Leaders ([opensource@newleaders.com](opensource@newleaders.com))
* [https://newleaders.com](https://newleaders.com)
