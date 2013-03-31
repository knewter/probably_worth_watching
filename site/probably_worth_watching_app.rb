require 'sinatra'
require 'sinatra/json'
require 'slim'
require 'json'
require_relative '../lib/probably_worth_watching'

class ProbablyWorthWatchingApp < Sinatra::Base
  get '/' do
    @videos = ProbablyWorthWatching::Video.all(order: [:id.desc], limit: 100)
    slim :index
  end

  get '/videos.json' do
    @videos = ProbablyWorthWatching::Video.all(order: [:id.desc], limit: 100)
    content_type :json
    if callback = params[:callback]
      "#{callback}(#{@videos.to_json})"
    else
      @videos.to_json
    end
  end
end
