Strategy = require('passport-lti').Strategy
attributeMap = require './LtiAttributeMap'

module.exports=(tenant, db)->
	userService = require('./UserService') db

	name: 'lti'
	instance:new Strategy
		consumerKey: tenant.strategy.consumerKey
		consumerSecret: tenant.strategy.consumerSecret
		,
		(attributes, next) ->
			userService.findOrCreate attributes, attributeMap, next