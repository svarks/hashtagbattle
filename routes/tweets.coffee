util         = require 'util'
TweetFetcher = require '../tweet-fetcher'

sendSSE = (res, options) ->
  options.data = JSON.stringify(options.data)

  for k, v of options
    res.write([k,v].join(':') + '\n')
  res.write('\n')

module.exports = (req, res) ->
  keywords = req.query.keywords
  keywords = [keywords] unless util.isArray(keywords)

  res.writeHead(200,
    'Content-Type'  : 'text/event-stream'
    'Cache-Control' : 'no-cache'
    'Connection'    : 'keep-alive'
  )
  res.write('\n')

  onSuccess = (data) ->
    sendSSE(res, data: data)

  onError = (message) ->
    sendSSE(res, event: 'remote-error', data: message, retry: 10000)
    fetcher.stop()
    res.end()

  fetcher = new TweetFetcher
  fetcher.start(keywords, onSuccess, onError)

  # making sure we close connection when client disconnect
  req.on 'close', -> fetcher.stop()
