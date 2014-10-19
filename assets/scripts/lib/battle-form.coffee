TweetFinder = require './tweet-finder'

class BattleForm
  constructor: (el) ->
    @$el = $(el)

    @finders = @$el.find('.tag-counter').map (i, el) ->
      new TweetFinder(el)

    @$el.on('submit', @_onSubmit)

  _onSubmit: (e) =>
    e.preventDefault()

    if @started
      @_stop()
    else
      @_start()

  _start: ->
    # both fields are required
    if $.grep(@_getKeywords(), (s) -> s == '').length > 0
      return false

    finder.start() for finder in @finders
    @started = true
    @_updateButton()
    @_updateURL()

  _stop: ->
    finder.stop() for finder in @finders
    @started = false
    @_updateButton()

  _updateButton: ->
    @$el.find(':submit').toggleClass('started', @started)

  _updateURL: ->
    return false unless window.history.replaceState

    keywords = @_getKeywords()
    params = { one: keywords[0], two: keywords[1] }

    window.history.replaceState({}, null, '?' + $.param(params))

  _getKeywords: ->
    @$el.find('.input').map (i, el) -> $(el).val()

module.exports = BattleForm
