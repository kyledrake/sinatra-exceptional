ENV['RACK_ENV'] = 'production'
require File.join(File.join(File.expand_path(File.dirname(__FILE__))), '..', 'lib', 'sinatra', 'exceptional')
require 'rack/test'
require 'minitest/autorun'
require 'webmock'
require 'json'

include Rack::Test::Methods
include WebMock::API

def mock_app(&block)
  @app = Sinatra.new PartyHard, &block
end

class PartyHard < Sinatra::Base
  class AndrewWKPartyError < StandardError; end

  set :exceptional_options, {
    key: 'key'
  }
  register Sinatra::Exceptional

  set :show_exceptions, false
  set :raise_errors,    true

  get '/partyhard' do
    'HELL YEAH'
  end

  get '/partyfail' do
    raise AndrewWKPartyError, 'you were just kicked in the face by a crowd surfer wearing combat boots'
  end
  
  post '/login' do
    raise 'hell'
  end

  error do
    report_exception
  end

end

def app
  @app || mock_app
end

describe 'A mock app' do
  it 'doesnt blow anything up' do
    get '/partyhard'
    last_response.ok?.must_equal true
    last_response.body.must_equal 'HELL YEAH'
  end

  it 'throws an party error like a boss' do
    lambda {
      get '/partyfail'
    }.must_raise PartyHard::AndrewWKPartyError
  end

  it 'returns error with raise errors false' do
    mock_app {
      set :raise_errors, false
    }
    get '/partyfail'
    last_response.status.must_equal 500
    last_response.errors.must_match /AndrewWKPartyError/
  end
end
