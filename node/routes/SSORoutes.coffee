module.exports = (passportify) ->
	router = require('express').Router()
	router.use passportify.intercept()
	router.use passportify.run "initialize"
	router.use passportify.run "session"

	router.get '/:tenantKey/initiate/saml',
		passportify.run "authenticate", 'saml'

	router.post '/consume/saml',
		passportify.run "authenticate", 'saml'
	,
		(req, res)->
				res.send req.user


	return router
