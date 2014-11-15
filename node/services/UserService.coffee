

module.exports = (db)->
	users = db.get 'users'

	findByProfile:(profile, next) ->
		console.log 'profile', profile
		id = profile.nameId
		@findById id, (err, user) ->
			return next null, user if user?
			users.insert
				_id:id
				username: profile.uid
				email: profile.email
				displayName: profile.cn
				firstName: profile.givenName
				lastName: profile.sn
			, (err, user)->
				return next err if err?
				next null, user

	findById:(id, next) ->
		users.findById id, (err, user)->
			return next err if err?
			next null, user