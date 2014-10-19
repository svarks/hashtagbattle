Twitter = require 'twitter'

twitter = new Twitter(
  consumer_key        : process.env.TWITTER_CONSUMER_KEY
  consumer_secret     : process.env.TWITTER_CONSUMER_SECRET
  access_token_key    : process.env.TWITTER_ACCESS_TOKEN
  access_token_secret : process.env.TWITTER_ACCESS_TOKEN_SECRET
)

class TweetFetcher
  start: (keywords, onSuccess, onError) ->

    parseTweet = (tweet) ->
      matchingKeywords = []

      for keyword in keywords
        # TODO: improve the search algorithm
        if tweet.text.match(new RegExp(keyword, 'i'))
          matchingKeywords.push(keyword)

      { text: tweet.text, keywords: matchingKeywords }

    twitter.stream 'statuses/filter', { track: keywords.join(',') }, (stream) =>
      stream.on 'data',  (tweet) -> onSuccess(parseTweet(tweet))
      stream.on 'error', (error) -> onError(error.source)
      @stream = stream

  stop: ->
    @stream.destroy()

module.exports = TweetFetcher
