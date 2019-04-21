require 'twitter_friendly'
require 'dotenv/load'

client = TwitterFriendly::Client.new(
    consumer_key: ENV['CK'],
    consumer_secret: ENV['CS'],
    access_token: ENV['AT'],
    access_token_secret: ENV['ATS']
)
