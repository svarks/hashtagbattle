express = require 'express'
dotenv  = require 'dotenv'

dotenv.load()

app = express()
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.get '/', require('./routes/home')
app.get '/tweets', require('./routes/tweets')

app.use express.static(__dirname + '/public')

app.listen(process.env.PORT || 3000)
