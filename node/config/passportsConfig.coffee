Passport = require('passport').Passport
async = require 'async'

module.exports = (appConfig, db)->
	userService = require('./UserService') db
	tenantService = require('./TenantService') db
	strategyFactory = require('./StrategyFactory') appConfig, db

	getConfig: (req, next) ->
		console.log 'in getConfig'
		key = 'testshib'
		async.waterfall [
			(next)-> tenantService.findByKey key, next
			(tenant, next)-> strategyFactory.make tenant, next
		], (err, strategy)->
			return next err if err?
			next null, key, strategy

	createInstance: (options, next) ->
		instance = new Passport()
		instance.use options.name, options.strategy
		instance.serializeUser (user, next) ->
			next null, user._id

		instance.deserializeUser (id, next) ->
			userService.findById id, (err, user) ->
				return next err if err?
				next null, user

		next null, instance




