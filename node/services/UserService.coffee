async = require 'async'

module.exports = (db)->
	users = db.get 'users'

	findByEmail:(email, next) ->
		users.findOne {email:email}, (err, user)->
			return next err if err?
			next null, user

	findById:(id, next) ->
		users.findById id, (err, user)->
			return next err if err?
			next null, user

	save:(user, next)->
		users.insert user, (err, user)->
			return next err if err?
			next null, user

	findOrCreate: (attributes, map, next)->
		attributeService = require('./AttributeService') attributes, map
		email = attributeService.get 'email'
		async.waterfall [
			(next)=>
				@findByEmail email, next
			(user, next)=>
				return finish null, user if user?
				attributeService.set @makeEmptyUser(), next
			(user, next)=>
				@save user, next
		], finish=(err, user)->
			return next err if err?
			next null, user

	makeEmptyUser: ->
		email:undefined
		displayname:undefined
		firstname:undefined
		lastname:undefined
		password:undefined