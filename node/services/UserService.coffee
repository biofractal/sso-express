module.exports = (db)->
	users = db.get 'users'

	findByProfile:(profile, next) ->
		mail = profile.mail

		@findByMail mail, (err, user)->
			return next err if err?
			return next null, user if user?
			users.insert
				mail: mail
				username: profile.uid
				displayName: profile.cn
				firstName: profile.givenName
				lastName: profile.sn
			, (err, user)->
				return next err if err?
				next null, user

	findByMail:(mail, next) ->
		users.findOne {mail:mail}, (err, user)->
			return next err if err?
			next null, user

	findById:(id, next) ->
		users.findById id, (err, user)->
			return next err if err?
			next null, user
