
module.exports = (app)->

	app.get '/', (req, res)->
		return res.send "Welcome #{req.user.firstName}" if req.isAuthenticated()
		res.send 'Login Failed'


