class TweetFinder
  url: '/api/tweets'
  source: null

  constructor: (el) ->
    @$el = $(el)

  start: ->
    @counter = 0
    @_updateCounter()

    @source = new EventSource("#{@url}?keywords=#{@_getKeyword()}")
    @source.addEventListener('message', @_onMessage)
    @source.addEventListener('remote-error', @_onError)

  stop: ->
    @source.close() if @source
    @_hideError()

  _getKeyword: ->
    @$el.find('.input').val()

  _onMessage: (e) =>
    @counter++
    @_updateCounter()
    @_hideError()

  _onError: (e) =>
    @_showError(e.data)

  _hideError: ->
    @$el.find('.error').addClass('hide')

  _showError: (message) ->
    @$el.find('.error')
      .removeClass('hide')
      .html(message)

  _updateCounter: ->
    @$el.find('.results').html(@counter)

module.exports = TweetFinder
