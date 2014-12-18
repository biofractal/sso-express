module.exports = (passportify) ->
	router = require('express').Router()
	router.use passportify.intercept()
	router.use passportify.run "initialize"
	router.use passportify.run "session"

	router.all '/:tenantKey/:strategy',
		passportify.authenticate()
	,
		(req, res)->
			res.json req.user

	router.post '/consume/:strategy',
		passportify.authenticate()
	,
		(req, res)->
				res.json req.user

	return router
