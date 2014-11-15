SamlStrategy = require('passport-saml').Strategy
UserService = require './UserService'

module.exports = (config, passport, db) ->
	userService = new UserService db

	passport.serializeUser (user, done) ->
		done null, user._id

	passport.deserializeUser (id, done) ->
		userService.findById id, (err, user) ->
			done err, user

	passport.use new SamlStrategy
		path: config.passport.saml.path
		entryPoint: config.passport.saml.entryPoint
		issuer: config.passport.saml.issuer
	,(profile, done) ->
		userService.findByProfile profile, (err, user) ->
			return done err if err?
			done null, user


