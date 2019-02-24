require 'bundler'
require 'dotenv'
Bundler.require

require './app'

Dotenv.load

Cloudinary.config do |config|
  config.cloud_name = ENV['CLOUD_NAME']
  config.api_name = ENV['CLOUD_API_KEY']
  config.api_secret = ENV['CLOUD_API_SECRET']
end

run Sinatra::Application