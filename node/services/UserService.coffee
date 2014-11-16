module.exports = (db)->
	users = db.get 'users'
	propertyNames =['email', 'userName', 'displayName', 'firstName', 'lastName']
	attributeNameMap =
		email: ['email', 'emailaddress', 'mail', 'urn:oid:0.9.2342.19200300.100.1.3', 'edupersonprincipalname ', 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6']
		displayname: ['displayname', 'urn:oid:2.16.840.1.113730.3.1.241', 'urn:oid:2.5.4.3', 'display name', 'cn']
		firstname: ['firstname', 'urn:oid:2.5.4.42', 'givenname', 'first name']
		lastname: ['lastname', 'urn:oid:2.5.4.4', 'surname', 'last name', 'sn']
		username: ['username', 'uid', 'urn:oid:0.9.2342.19200300.100.1.1']

	findByProfile:(profile, next) ->
		email = @getValue profile, 'email'
		@findByEmail email, (err, user)=>
			return next err if err?
			return next null, user if user?
			user = @makeUser profile
			users.insert user, (err, user)->
				return next err if err?
				next null, user

	findByEmail:(email, next) ->
		users.findOne {email:email}, (err, user)->
			return next err if err?
			next null, user

	findById:(id, next) ->
		users.findById id, (err, user)->
			return next err if err?
			next null, user

	makeUser: (profile)->
		user = {}
		user[propertyName] = @getValue profile, propertyName for propertyName in propertyNames
		return user

	getValue: (profile, propertyName)->
		attributeNames = attributeNameMap[propertyName.toLowerCase()]
		for attributeName in attributeNames
			return profile[attributeName] if profile[attributeName]?

