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

  def setup
    @starwars = "How did I get into this mess? I really don't know how. We seem to be made to suffer. It's our lot in life. I've got to rest before I fall apart. My joints are almost frozen. What a desolate place this is. Where are you going? Well, I'm not going that way. It's much too rocky. This way is much easier. What makes you think there are settlements over there? Don't get technical with me. What mission? What are you talking about? I've had just about enough of you! Go that way! You'll be malfunctioning within a day, you nearsighted scrap pile! And don't let me catch you following me begging for help, because you won't get it. No more adventures. I'm not going that way.\n"
    @pirate = "Schooner lugsail heave down gun fire in the hole broadside hail-shot Shiver me timbers clipper come about. Aye shrouds fire ship heave to lass wench quarter jib chase guns boatswain. Quarterdeck pressgang dead men tell no tales man-of-war scuppers loot black spot stern barque holystone.\n"
    @kitty = "Immediately regret falling into bathtub stare at ceiling. Vommit food and eat it again groom yourself 4 hours - checked, have your beauty sleep 18 hours - checked, be fabulous for the rest of the day - checked!. Intently stare at the same spot loves cheeseburgers for behind the couch, for i like big cats and i can not lie. Hopped up on catnip human give me attention meow scratch the furniture howl on top of tall thing but scratch the box, or scratch leg; meow for can opener to feed me and chase ball of string. Purr. Go into a room to decide you didn't want to be in there anyway hopped up on catnip. Ignore the squirrels, you'll never catch them anyway lick butt and make a weird face for destroy couch as revenge howl on top of tall thing. Purr while eating lay on arms while you're using the keyboard, curl up and sleep on the freshly laundered towels but rub face on everything, but scamper but kitty scratches couch bad kitty. Purr destroy the blinds sit in box and roll on the floor purring your whiskers off sleep on keyboard. Kitty scratches couch bad kitty.\n"

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

  def test_starwars
    get "/starwars"
    assert last_response.ok?, last_response.status
    assert_equal @starwars, last_response.body

    get "/starwars/3"
    assert last_response.ok?, last_response.status
    assert_equal @starwars*3, last_response.body

    get "/starwars/luke"
    refute last_response.ok?
    assert_equal 404, last_response.status
    assert last_response.body.include?("We're sorry. We couldn't that."), last_response.body
  end

  def test_pirate
    get "/pirate"
    assert last_response.ok?, last_response.status
    assert_equal @pirate, last_response.body

    get "/pirate/3"
    assert last_response.ok?, last_response.status
    assert_equal @pirate*3, last_response.body

    get "/pirate/2/4"
    refute last_response.ok?
    assert_equal 404, last_response.status
    assert last_response.body.include?("We're sorry. We couldn't that."), last_response.body
  end

  def test_kitty
    get "/kitty"
    assert last_response.ok?, last_response.status
    assert_equal @kitty, last_response.body

    get "/kitty/3"
    assert last_response.ok?, last_response.status
    assert_equal @kitty*3, last_response.body

    get "/kitty/cat/meow"
    refute last_response.ok?
    assert_equal 404, last_response.status
    assert last_response.body.include?("We're sorry. We couldn't that."), last_response.body
  end


  def test_a_404
    get "/serghy45jt65ed"
    refute last_response.ok?
    assert_equal 404, last_response.status
    assert last_response.body.include?("We're sorry. We couldn't that."), last_response.body
  end

  def test_current_time
    get "/current_time"
    assert last_response.ok?, last_response.status
    assert_equal "EST #{Time.new.strftime("%I:%M:%S%p, %h %d %Y")}", last_response.body
  end


end
