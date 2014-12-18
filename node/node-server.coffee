require('dotenv').load()
config = require('./config')[process.env.NODE_ENV || 'development']
db = require('monk') process.env.MONGO_URL
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
session = require 'express-session'
winston = require 'winston'
passportify = require('./Passportify') require('./PassportifyConfig') config, db

#app
app = express()
app.use cookieParser()
app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()
app.use session { secret: process.env.SESSION_SECRET, saveUninitialized: true, resave: true }


#CORS
app.all '*', (req, res, next) ->
	res.header 'Access-Control-Allow-Origin', '*'
	res.header 'Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept'
	next()

app.use '/api', require('./TenantRoutes') db
app.use '/api/sso', require('./SSORoutes') passportify


#app start
app.listen config.app.port, ->
	winston.info "#{config.app.name} listening on port #{config.app.port}"

