#!/usr/bin/env ruby

require 'socket'
require 'net/http'

myip = Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

pbcopy( "http://#{myip}:8000" )

#http://gotonow.herokuapp.com/url
uri = URI('http://gotonow.herokuapp.com/url')
res = Net::HTTP.post_form(uri, 'url' => "http://#{myip}:8000", 'max' => '50')
puts res.body