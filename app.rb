

class App

  attr_accessor :env, :path, :num, :headers, :code, :body

  def initialize(env)
    @env = env
    @path = env["PATH_INFO"].split('/')
    @num = path[2].to_i #env["REQUEST_PATH"].sub(/\/\w+[|\/]/, "")
    @num = 1 if num.to_i.zero?
    @headers = {'Content-Type' => 'text/html'}
    @code = '404'
    @body = ["404: You Have Died of Dysentery.  **GAME OVER**"]
  end

  def serve
    # case path[1]
    # when "lipsum" then list
    # when
    # end
    [code, headers, body]
  end


  def self.call(env)
    new(env).serve
  end

end
