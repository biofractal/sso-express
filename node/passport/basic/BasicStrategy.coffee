Strategy = require('passport-http').BasicStrategy

module.exports=(db)->
	userService = require('./UserService') db

	name: 'basic'
	instance:new Strategy (email, password, next) ->
			userService.findByEmail email, (err, user) ->
				return next err if err?
				return next null, false unless user?
				return next null, false unless user.password is password
				next null, user