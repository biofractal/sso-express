require('dotenv').load()
express = require 'express'
bodyParser = require 'body-parser'

#app setup
app = express()
app.set('port', process.env.PORT ? 3000)
app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()
app.use express.static __dirname

app.all '*', (req, res, next) ->
	res.header 'Access-Control-Allow-Origin', '*'
	res.header 'Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept'
	next()

#routes
new exports.TestRoutes app

#app start
port = app.get 'port'
app.listen port, ->
	require('winston').info "Express server listening on port #{port}"


