TweetFinder  = require './tweet-finder'
TweetCounter = require './tweet-counter'

class BattleForm
  constructor: (el) ->
    @$el = $(el)
    @$el.on('submit', @_onSubmit)

  _onSubmit: (e) =>
    e.preventDefault()

    if @started
      @_stop()
    else
      @_start()

  _start: ->
    counters = @_buildCounters()
    keywords = $.map counters, (counter) -> counter.keyword

    if $.grep(keywords, (s) -> s == '').length > 0
      @_showError('Please enter both tags first.')
      return false

    @finder = new TweetFinder(keywords)

    @finder.on 'message', (data) =>
      @_hideError()

      for counter in counters
        unless $.inArray(counter.keyword, data.keywords) == -1
          counter.increment()

    @finder.on 'error', (message) =>
      if message = 'Exceeded connection limit for user'
        message = 'Too many connections, waiting...'
      @_showError(message)

    @finder.start()
    @started = true
    @_updateButton()
    @_updateURL(keywords)

  _stop: ->
    @finder.stop()
    @started = false
    @_updateButton()

  _buildCounters: ->
    @$el.find('.tag-counter').map (i, el) ->
      counter = new TweetCounter($(el).find('.results'))
      counter.keyword = $(el).find('.input').val()
      counter

  _showError: (message) ->
    @$el.find('.error')
      .html(message)
      .removeClass('hide')

  _hideError: ->
    @$el.find('.error')
      .addClass('hide')

  _updateButton: ->
    @$el.find(':submit')
      .toggleClass('started', @started)

  _updateURL: (keywords) ->
    return false unless window.history.replaceState
    params = { one: keywords[0], two: keywords[1] }
    window.history.replaceState({}, null, '?' + $.param(params))

module.exports = BattleForm
