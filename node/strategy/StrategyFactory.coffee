fs = require 'fs'
BasicStrategy = require('passport-http').BasicStrategy
SamlStrategy = require('passport-saml').Strategy
samlAttributeMap = require './SamlAttributeMap'
LtiStrategy = require 'passport-lti'
ltiAttributeMap = require './LtiAttributeMap'

module.exports = (appConfig, db)->
	userService = require('./UserService') db

	make:(tenant, next)->
		name = tenant.strategy.name
		switch name
			when 'saml'
				return next null,
					name: name
					instance:new SamlStrategy
						path: appConfig.passport.saml.path
						decryptionPvk: fs.readFileSync appConfig.passport.saml.privateKeyFile
						issuer: appConfig.passport.saml.issuer
						identifierFormat: tenant.strategy.identifierFormat
						entryPoint: tenant.strategy.entryPoint
						additionalParams:{'RelayState':tenant.key}
						,
						(attributes, next) ->
							userService.findOrCreate attributes, samlAttributeMap, next

			when 'lti'
				return next null,
					name: name
					instance:new LtiStrategy
						consumerKey: tenant.strategy.consumerKey
						consumerSecret: tenant.strategy.consumerSecret
						,
						(attributes, next) ->
							userService.findOrCreate attributes, ltiAttributeMap, next

			when 'basic'
				return next null,
					name: name
					instance:new BasicStrategy (email, password, next) ->
							userService.findByEmail email, (err, user) ->
								return next err if err?
								return next null, false unless user?
								return next null, false unless user.password is password
								next null, user


