
module.exports = (app)->

	app.get '/', (req, res)->
		return res.send "Welcome #{req.user.displayName}" if req.isAuthenticated()
		res.send 'Login Failed'


