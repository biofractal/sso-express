require('dotenv').load()
config = require('./config')[process.env.NODE_ENV || 'development']
db = require('monk')(process.env.MONGO_URL)
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
session = require 'express-session'
passport = require 'passport'
samlStrategy = require 'passport-saml'
winston = require 'winston'

#app
app = express()
app.set 'port', process.env.PORT ? 3000
app.use express.static __dirname
app.use cookieParser()
app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()
app.use session { secret: process.env.SESSION_SECRET, saveUninitialized: true, resave: true }
app.use passport.initialize()
app.use passport.session()
app.all '*', (req, res, next) ->
	res.header 'Access-Control-Allow-Origin', '*'
	res.header 'Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept'
	next()

#passport
require('./passport')(config, passport, db)

#routes
require('./AppRoutes')(app)
require('./SSORoutes')(app, config, passport)


#app start
port = app.get 'port'
app.listen port, ->
	winston.info "#{config.app.name} listening on port #{port}"


