fs = require 'fs'
Strategy = require('passport-saml').Strategy
attributeMap = require './SamlAttributeMap'

module.exports=(config, tenant, db)->
	userService = require('./UserService') db
	sp=config.passport.saml
	idp=tenant.strategy

	name: 'saml'
	instance:new Strategy
		path: sp.callback
		decryptionPvk: fs.readFileSync sp.privateKeyFile
		issuer: sp.issuer
		identifierFormat: idp.identifierFormat
		entryPoint: idp.entryPoint
		additionalParams:{'RelayState':tenant.key}
		,
		(attributes, next) ->
			userService.findOrCreate attributes, attributeMap, next