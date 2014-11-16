SamlStrategy = require('passport-saml').Strategy
UserService = require './UserService'
fs = require 'fs'

module.exports = (config, passport, db) ->
	userService = new UserService db
	privateKey = fs.readFileSync(config.passport.saml.privateKey)

	passport.serializeUser (user, done) ->
		done null, user._id

	passport.deserializeUser (id, done) ->
		userService.findById id, (err, user) ->
			done err, user

	passport.use new SamlStrategy
		path: config.passport.saml.path
		issuer: config.passport.saml.issuer
		identifierFormat: config.passport.saml.identifierFormat
		decryptionPvk: privateKey
		entryPoint: config.passport.saml[config.app.idp].entryPoint
	,(profile, done) ->
		console.log profile
		userService.findByProfile profile, (err, user) ->
			return done err if err?
			done null, user


