router = require('express').Router()

router.get '/', (req, res)->
	console.log 'in root'
	return res.send "Welcome #{req.user.displayname} with email of #{req.user.email}" if req.isAuthenticated()
	res.send 'Login Failed'

router.get '/test', (req, res)->
	console.log 'in test'
	res.send 'test page'

module.exports = router