require 'rack'
require_relative 'app'

app = App
# app = Proc.new do |env|
#   # Finds the num of paragraphs requested, or sets it to 1
#   num = env["REQUEST_PATH"].sub(/\/\w+[|\/]/, "")
#   num = 1 if num.to_i.zero?
#
#   # Replace the code below with your code (and remove this comment)
#
#   def four
#     code = '404'
#     "404: you suck"
#   end
#
#   def one
#     "one was selected"
#   end
#
#   def two
#     "two was selected"
#   end
#
#   def three
#     "three was selected"
#   end
#
#   code = '200'
#   body = []
#   body << case num.to_i
#   when 1 then one
#   when 2 then two
#   when 3 then three
#   else four
#   end
#
#   ['200', {'Content-Type' => 'text/html'}, [env.inspect]]
#
#   [code, {'Content-Type' => 'text/html'}, body ]
# end

Rack::Handler::WEBrick.run app
