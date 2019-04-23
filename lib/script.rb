require 'dotenv/load'
require 'twitter_friendly'

require_relative 'connection'
require_relative 'user'

logger = Logger.new(STDOUT)

client = TwitterFriendly::Client.new(
    consumer_key: ENV['CK'],
    consumer_secret: ENV['CS'],
    access_token: ENV['AT'],
    access_token_secret: ENV['ATS']
)

str = '技術書典 OR #技術書典'
tweets = client.search(str, count: 10000)

logger.info "tweets #{tweets.size}"

users = tweets.map do |t|
  if t[:retweeted_status]
    user = t[:retweeted_status][:user]
    user[:tweet] = t[:retweeted_status][:text]
  else
    user = t[:user]
    user[:tweet] = t[:text]
  end

  user
end.uniq do |u|
  u[:id]
end

logger.info "users #{users.size}"

users.each do |u|
  User.create!(
      uid: u[:id],
      screen_name: u[:screen_name],
      name: u[:name],
      description: u[:description].gsub(/\R/, ' '),
      tweet: u[:tweet].gsub(/\R/, ' '),
  )
rescue ActiveRecord::RecordNotUnique => e
  # Do nothing.
end

logger.info "User #{User.all.size}"
