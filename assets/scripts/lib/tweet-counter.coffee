class TweetCounter
  constructor: (el) ->
    @$el = $(el)
    @reset()

  increment: ->
    @counter++
    @_update()

  reset: ->
    @counter = 0
    @_update()

  _update: ->
    @$el.html(@counter)

module.exports = TweetCounter
