require_relative "piratelip"
require_relative "starwarslip"
require_relative "kittylip"
require 'pry'

class App

  attr_accessor :env, :path, :headers, :code, :body

  def initialize(env)
    @env = env
    @path = env["PATH_INFO"].split('/')
    @headers = {'Content-Type' => 'text/html'}
    @code = '200'
    @body = []
  end

  def four
    self.code = '404'
    "404: We're sorry. We couldn't that. You Have Died of Dysentery.  **GAME OVER**"
  end

  def liplist
    path[2] ? four : "Lipsum options: 1) starwars 2) kitty 3) pirate"
  end

  def lipsum(lip)
    n = path[2] ? path[2].to_i : 1
    path[3] || n == 0 ? four : lip.(n)
  end

  def time
    zone = path[2] || 'EST'
    begin #I don't have easy access to the hash of zones, so this catches the error if it doesn't exist.
      t = Time.at(Time.now.utc + Time.zone_offset(zone)).strftime("%I:%M:%S%p, %h %d %Y")
    rescue # could also just call a 404 here
      t = Time.at(Time.now.utc + Time.zone_offset('EST')).strftime("is not a timezone, using default EST, %I:%M:%S%p, %h %d %Y")
    end
    path[3] ? four : "#{zone.upcase} #{t}"
  end

  def serve
    body << case path[1].downcase
    when "lipsums"      then liplist
    when "starwars"     then lipsum(Starwars)
    when "kitty"        then lipsum(Kitty)
    when "pirate"       then lipsum(Pirate)
    when "current_time" then time
    else four
    end
    [self.code, headers, body]
  end

  def self.call(env)
    new(env).serve
  end

end
