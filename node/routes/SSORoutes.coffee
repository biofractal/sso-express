module.exports = (passportify) ->
	router = require('express').Router()
	router.use passportify.intercept()
	router.use passportify.run "initialize"
	router.use passportify.run "session"

	router.get '/:tenantKey/initiate/:strategy',
		passportify.authenticate()
	,
		(req, res)->
			console.log 'res', res
			res.json req.user

	router.post '/consume/saml',
		passportify.authenticate()
	,
		(req, res)->
				res.json req.user

	return router
