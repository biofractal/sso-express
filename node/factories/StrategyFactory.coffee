fs = require 'fs'
SamlStrategy = require('passport-saml').Strategy
BasicStrategy = require('passport-http').BasicStrategy

module.exports = (appConfig, db)->
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
						(profile, next) ->
							samlService = require('./SamlService') db
							samlService.findByProfile profile, (err, user) ->
								return next err if err?
								next null, user
			when 'basic'
				return next null,
					name: name
					instance:new BasicStrategy (email, password, next) ->
							userService = require('./UserService') db
							userService.findByEmail email, (err, user) ->
								return next err if err?
								return next null, false unless user?
								return next null, false unless user.password is password
								next null, user