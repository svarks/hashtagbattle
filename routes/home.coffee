module.exports = (req, res) ->
  res.render('index', params: req.query)
