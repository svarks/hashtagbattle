Twitter = require 'twitter'

twitter = new Twitter(
  consumer_key        : process.env.TWITTER_CONSUMER_KEY
  consumer_secret     : process.env.TWITTER_CONSUMER_SECRET
  access_token_key    : process.env.TWITTER_ACCESS_TOKEN
  access_token_secret : process.env.TWITTER_ACCESS_TOKEN_SECRET
)

class TweetFetcher
  fetch: (keywords, onSuccess, onError) ->
    twitter.stream 'statuses/filter', { track: keywords }, (stream) ->
      stream.on 'data', onSuccess
      stream.on 'error', (error) -> onError(error.source)

module.exports = TweetFetcher
