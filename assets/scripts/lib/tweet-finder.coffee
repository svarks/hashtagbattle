class TweetFinder
  url: '/tweets'
  source: null

  constructor: (@keywords) ->
    @callbacks = {}

  on: (event, cb) ->
    @callbacks[event] = cb

  start: ->
    @source = new EventSource(@url + '?' + $.param(keywords: @keywords))
    @source.addEventListener('message', @_onMessage)
    @source.addEventListener('remote-error', @_onError)

  stop: ->
    @source.close() if @source

  _onMessage: (e) =>
    @_runCallback('message', JSON.parse(e.data))

  _onError: (e) =>
    @_runCallback('error', JSON.parse(e.data))

  _runCallback: (event, data) ->
    cb = @callbacks[event]
    cb(data) if cb

module.exports = TweetFinder
