fs = require 'fs'
Strategy = require('passport-saml').Strategy
attributeMap = require './SamlAttributeMap'

module.exports=(config, tenant, db)->
	userService = require('./UserService') db
	saml=config.passport.saml
	decryptionPvk=fs.readFileSync saml.privateKeyFile

	name: 'saml'
	instance:new Strategy
		path: saml.path
		decryptionPvk: decryptionPvk
		issuer: saml.issuer
		identifierFormat: tenant.strategy.identifierFormat
		entryPoint: tenant.strategy.entryPoint
		additionalParams:{'RelayState':tenant.key}
		,
		(attributes, next) ->
			userService.findOrCreate attributes, attributeMap, next