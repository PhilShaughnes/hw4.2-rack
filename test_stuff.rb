require 'rack'
require 'minitest/autorun'
require 'minitest/pride'
require "rack/test"
require_relative 'app'

class TestThing < Minitest::Test

  include Rack::Test::Methods

  def app
    App
  end

  def test_lipsums
    get "/lipsums"
    assert last_response.ok?, last_response.status
    assert_equal "Lipsum options: 1) starwars 2) kitty 3) pirate", last_response.body

    get "/lipsums/5"
    refute last_response.ok?
    assert_equal 404, last_response.status
    assert last_response.body.include?("We're sorry. We couldn't that."), last_response.body
  end

  def test_lipsums
    get "/starwars"
    assert last_response.ok?, last_response.status
    assert_equal "How did I get into this mess? I really don't know how. We seem to be made to suffer. It's our lot in life. I've got to rest before I fall apart. My joints are almost frozen. What a desolate place this is. Where are you going? Well, I'm not going that way. It's much too rocky. This way is much easier. What makes you think there are settlements over there? Don't get technical with me. What mission? What are you talking about? I've had just about enough of you! Go that way! You'll be malfunctioning within a day, you nearsighted scrap pile! And don't let me catch you following me begging for help, because you won't get it. No more adventures. I'm not going that way.\n", last_response.body
  end


  def test_a_404
    get "/serghy45jt65ed"
    refute last_response.ok?
    assert_equal 404, last_response.status
    assert last_response.body.include?("We're sorry. We couldn't that."), last_response.body
  end


end
