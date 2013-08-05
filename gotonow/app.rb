require 'sinatra'
require 'sinatra/partial'
require 'sinatra/reloader' if development?

require 'redis'

configure do
  redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
  uri = URI.parse(redisUri) 
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/' do
  erb :main
end

get '/url', :agent => /iPhone/ do
  url = $redis.lpop( "urls" )
  if url
    redirect url
  else
    { :result => "error" }.to_json 
  end
end

get '/url' do
  url = $redis.lpop( "urls" )
  if url
    url
  else
    { :result => "error" }.to_json 
  end
end

post '/url' do
  if params[:url]
    $redis.lpush( "urls", params[:url] )

    { :result => "success", :url => params[:url] }.to_json
  else
    { :result => "invalid params" }.to_json
  end
end