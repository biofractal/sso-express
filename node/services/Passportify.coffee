async = require 'async'
eidetic = require 'eidetic'

module.exports = (options) ->
	index = 0
	cache = new eidetic {canPutWhenFull: true}
	getTenantKey = options?.getTenantKey
	makeStrategy = options?.makeStrategy
	makePassport = options?.makePassport

	getStrategy: (tenantKey, next) ->
		key = "#{tenantKey}.strategy"
		strategy = cache.get key
		return next null, tenantKey, strategy if strategy?
		makeStrategy tenantKey, (err, strategy) ->
			return next err if err?
			cache.put key, strategy
			next null, tenantKey, strategy

	getPassport: (tenantKey, strategy, next) ->
		key = "#{tenantKey}.passport"
		passport = cache.get key
		return next null, passport if passport?
		makePassport strategy, (err, passport) ->
			return next err if err?
			cache.put key, passport
			next null, passport

	intercept: ->
		(req, res, next) =>
			async.waterfall [
				(next)->
					getTenantKey req, next
				(tenantKey,next)=>
					@getStrategy tenantKey, next
				(tenantKey, strategy, next)=>
					@getPassport tenantKey, strategy, next
			], (err, passport)->
				return next err if err?
				req.passport = passport
				next()

	run: (name, args...) ->
		key = "#{name}.#{index++}"
		(req, res, next) ->
			cache.put key, req.passport[name].apply req.passport, args unless cache.get(key)?
			cache.get(key) req, res, next