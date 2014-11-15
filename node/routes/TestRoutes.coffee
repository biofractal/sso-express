testService = require './TestService'

module.exports = (app)->

	app.get '/sso/ping1', (req, res)=>
		res.send testService.ping1()

	app.get '/sso/ping2', (req, res)=>
		res.send testService.ping2()
