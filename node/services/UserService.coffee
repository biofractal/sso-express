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

	makeEmptyUser: ->
		email:undefined
		password:undefined
		displayname:undefined
		firstname:undefined
		lastname:undefined
