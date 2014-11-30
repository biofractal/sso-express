router = require('express').Router()

module.exports = (passports) ->

	# router.get '/saml/initiate/tenant/:key', (req, res)->
	# 	key = req.params.key
	# 	console.log 'key', key
	# 	console.log req
	# 	res.send key

	router.get '/saml/initiate/tenant/:key',
		passports.middleware "authenticate", 'saml',
			successRedirect: "/"
			failureRedirect: "/"

	router.post '/saml/consume',
		passports.middleware "authenticate", 'saml',
			successRedirect: "/"
			failureRedirect: "/"

	return router
