Passport = require('passport').Passport
routes = require('routes')()
async = require 'async'

module.exports = (appConfig, db)->
	userService = require('./UserService') db
	tenantService = require('./TenantService') db
	strategyFactory = require('./StrategyFactory') appConfig, db
	routes.addRoute '/:tenentKey/:strategy', ->

	getTenantKey: (req, next) ->
		key = req.body?.RelayState ? routes.match(req.path).params.tenentKey
		next null, key

	makeStrategy: (tenantKey, next) ->
		async.waterfall [
			(next)->
				tenantService.findByKey tenantKey, next
			(tenant, next)->
				strategyFactory.make tenant, next
		], (err, strategy)->
			return next err if err?
			next null, strategy

	makePassport: (strategy, next) ->
		passport = new Passport()
		passport.use strategy.name, strategy.instance

		passport.serializeUser (user, next) ->
			next null, user._id

		passport.deserializeUser (id, next) ->
			userService.findById id, (err, user) ->
				return next err if err?
				next null, user

		next null, passport




