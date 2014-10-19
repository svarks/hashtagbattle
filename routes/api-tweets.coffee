TweetFetcher = require '../tweet-fetcher'

fetcher = new TweetFetcher

module.exports = (req, res) ->
  res.writeHead(200,
    'Content-Type'  : 'text/event-stream'
    'Cache-Control' : 'no-cache'
    'Connection'    : 'keep-alive'
  )
  res.write('\n')

  sendMessage = (options) ->
    for k, v of options
      res.write([k,v].join(':') + '\n')
    res.write('\n')

  onSuccess = (tweet) ->
    sendMessage(data: tweet.text)

  onError = (message) ->
    sendMessage(event: 'remote-error', data: message)

  fetcher.fetch(req.query.keywords, onSuccess, onError)
