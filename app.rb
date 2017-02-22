require_relative "piratelip"
require_relative "starwarslip"
require_relative "kittylip"
require 'pry'

class App

  attr_accessor :env, :path, :num, :headers, :code, :body

  def initialize(env)
    @env = env
    @path = env["PATH_INFO"].split('/')
    @num = path[2] ? path[2].to_i : 1 #env["REQUEST_PATH"].sub(/\/\w+[|\/]/, "")
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

  def serve
    body << case path[1].downcase
    when "lipsums"      then liplist
    when "starwars"     then lipsum(Starwars)
    when "kitty"        then lipsum(Kitty)
    when "pirate"       then lipsum(Pirate)
    when "current_time" then Time.new.strftime("%H:%M:%S %h %d %Y")
    else four
    end
    [self.code, headers, body]
  end

  def self.call(env)
    new(env).serve
  end

end
