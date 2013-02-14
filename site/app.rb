require 'sinatra'
require 'sinatra/json'
require 'slim'
require 'pry'
require_relative '../lib/probably_worth_watching'

get '/' do
  @videos = ProbablyWorthWatching::Video.all
  slim :index
end

get '/videos.json' do
  @videos = ProbablyWorthWatching::Video.all
  content_type :json
  @videos.to_json
end
