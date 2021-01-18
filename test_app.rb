# frozen_string_literal: true

require './app'
require 'minitest/autorun'
require 'rack/test'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_memos_response_is_ok
    get '/memos'
    assert last_response.ok?
  end

  def test_new_response_is_ok
    get '/memos/new'
    assert last_response.ok?
  end
end
