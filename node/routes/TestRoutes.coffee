class exports.TestRoutes

	constructor :(@app) ->
		@testService = exports.TestService

		@app.get '/sso/ping', (req, res)=>
			res.send @testService.ping()


