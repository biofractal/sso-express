module.exports = ->
		attributeNameMap =
			email:[
				'emailaddress'
				'mail'
				'urn:oid:0.9.2342.19200300.100.1.3'
				'edupersonprincipalname '
				'urn:oid:1.3.6.1.4.1.5923.1.1.1.6'
				]
			,
			displayname:[
				'displayname'
				'urn:oid:2.16.840.1.113730.3.1.241'
				'urn:oid:2.5.4.3'
				'display name'
				'cn'
				]
			,
			firstname:[
				'firstname'
				'urn:oid:2.5.4.42'
				'givenname'
				'first name'
				]
			,
			lastname:[
				'lastname'
				'urn:oid:2.5.4.4'
				'surname'
				'last name'
				'sn'
				]
			username:[
				'uid'
				'urn:oid:0.9.2342.19200300.100.1.1'
				]

	getValue: (profile, propertyName)->
		value = profile[propertyName]
		return value if value?
		attributeNames = attributeNameMap[propertyName.toLowerCase()]
		for name in attributeNames
			return profile[name] if profile[name]?



