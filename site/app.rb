require 'sinatra'
require 'slim'
require_relative '../lib/probably_worth_watching'

get '/' do
  @videos = ProbablyWorthWatching::Video.all
  slim :index
end
