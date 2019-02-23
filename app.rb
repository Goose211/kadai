require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'

#検索機能実装
require 'open-uri'
require 'net/http'
require 'json'


enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

get '/' do
  erb :index
end


get '/signup' do
  erb :sign_up
end

post '/search' do
@musics = []
  erb :search
end

get '/home' do
  erb :home
end


post '/signin' do
user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

post '/signup' do
  @user = User.create(name:params[:name],
    password:params[:password],
  password_confirmation:params[:password_confirmation],
  img: params[:file])

  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/search' do
  keyword = params[:keyword]
  uri = URI("https://itunes.apple.com/search")
  uri.query = URI.encode_www_form({ term: keyword, country: "US", media: "music", limit: 10})
  res = Net::HTTP.get_response(uri)
  returned_json = JSON.parse(res.body)
  @musics = returned_json["results"]

  erb :search
end
