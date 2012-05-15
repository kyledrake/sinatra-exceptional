# Sinatra::Exceptional

This is a plugin for exceptional and Sinatra. I am using it manually via the Sinatra error block, and it doesn't really work automatically yet. As such, it's probably not very useful for most people.

But it's a good starting point for Sinatra support, so if you'd like to hack on this, let me know and I'll add you as a contributor!

The one feature I've added (for reason of personal requirement) is params filtering, so you can block out passwords from your exception reports.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra-exceptional', :require => 'sinatra/exceptional'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-exceptional

## Usage

    require 'sinatra'
    require 'sinatra/exceptional'

    configure do
      Exceptional.logger
    end

    set :exceptional_options, {
      key: '<YOUR_API_KEY>',
      params_filter: /password/i
    }

    # Test with curl -d "password=sex" http://127.0.0.1:4567
    post '/' do
      raise StandardError, 'testing!'
    end

    error do
      report_exception # This sends the exception to Exceptional, but does not halt.
      'derp'
    end

## Running the Tests

    $ bundle install
    $ bundle exec rake

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

* Automatic exceptions
* Tests need to use webmock
* Tests for password filter (can't really do it without the mock)