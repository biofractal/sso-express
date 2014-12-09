

module.exports = (db)->
	userService = require('./UserService')(db)

	attributeNameMap =
		email: [
			'email'
			'emailaddress'
			'mail'
			'urn:oid:0.9.2342.19200300.100.1.3'
			'edupersonprincipalname '
			'urn:oid:1.3.6.1.4.1.5923.1.1.1.6'
		]
		displayname: [
			'displayname'
			'urn:oid:2.16.840.1.113730.3.1.241'
			'urn:oid:2.5.4.3'
			'display name'
			'cn'
		]
		firstname: [
			'firstname'
			'urn:oid:2.5.4.42'
			'givenname'
			'first name'
		]
		lastname: [
			'lastname'
			'urn:oid:2.5.4.4'
			'surname'
			'last name'
			'sn'
		]
		username: [
			'username'
			'uid'
			'urn:oid:0.9.2342.19200300.100.1.1'
		]

	findByProfile:(profile, next) ->
		console.log 'profile', profile
		email = @getAttributeValue profile, 'email'
		userService.findByEmail email, (err, user)=>
			return next err if err?
			return next null, user if user?
			user = userService.makeEmptyUser()
			user[property] = @getAttributeValue profile, property for own property of user
			userService.save user, next

	getAttributeValue: (profile, name)->
		mappings = attributeNameMap[name.toLowerCase()]
		return unless mappings?
		for own property of profile
			return profile[property] if mappings.some (x)-> x is property.toLowerCase()



