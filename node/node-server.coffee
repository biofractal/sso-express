require('dotenv').load()
appConfig = require('./appConfig')[process.env.NODE_ENV || 'development']
db = require('monk') process.env.MONGO_URL
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
session = require 'express-session'
winston = require 'winston'
Passports =  require 'passports'
passports = new Passports require('./passportsConfig') appConfig, db

#app
app = express()
app.use cookieParser()
app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()
app.use session { secret: process.env.SESSION_SECRET, saveUninitialized: true, resave: true }
app.use passports.attach()
app.use passports.middleware "initialize"
app.use passports.middleware "session"

#CORS
app.all '*', (req, res, next) ->
	res.header 'Access-Control-Allow-Origin', '*'
	res.header 'Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept'
	next()

#routes
app.use '/', require('./AppRoutes')
app.use '/sso', require('./SSORoutes') passports

#app start
app.listen appConfig.app.port, ->
	winston.info "#{appConfig.app.name} listening on port #{appConfig.app.port}"
