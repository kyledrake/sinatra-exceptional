require 'exceptional'
require 'sinatra/base'
require 'sinatra/exceptional/version'
require 'digest/md5'

module Exceptional
  class Catcher
    class << self
      def handle_with_sinatra(exception, environment, request, opts)
        if Config.should_send_to_api?
          data = SinatraExceptionData.new exception, environment, request, opts
          Remote.error data
        end
      end
    end
  end

  class SinatraExceptionData < ExceptionData
    FILTERED_TEXT = '[FILTERED]'

    def initialize(exception, environment, request, opts={})
      super exception
      @opts = opts
      @environment = environment
      @request = request
    end

    def framework
      "sinatra"
    end

    def params
      params = {}

      if @opts && @opts[:params_filter]
        @request.params.each do |key,original_value|
          params[key] =  key.to_s.match(@opts[:params_filter]) ? FILTERED_TEXT : original_value
        end
      else
        params = @request.params
      end
      params
    end

    def extra_stuff

      return {} if @request.nil?
      {
        'request' => {
          'url' => "#{@request.url}",
          'parameters' => params,
          'request_method' => @request.request_method.to_s,
          'remote_ip' => @request.ip,
          'headers' => extract_http_headers(@environment),
          'session' => self.class.sanitize_session(@request)
        }
      }
    end
  end
end

module Sinatra
  module Exceptional
    def self.registered(app)
      app.helpers do
        def report_exception
          ::Exceptional.configure settings.exceptional_options[:key] unless ::Exceptional::Config.api_key
          ::Exceptional::Catcher.handle_with_sinatra env['sinatra.error'], ENV, request, settings.exceptional_options
        end
      end
    end
  end

  register Exceptional
end
