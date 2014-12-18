module.exports = (config, db)->
	make:(tenant, next)->
		switch tenant.strategy.name
			when 'saml'
				return next null, require('./SamlStrategy')(config, tenant, db)
			when 'lti'
				return next null, require('./LtiStrategy')(tenant, db)
			when 'basic'
				return next null, require('./BasicStrategy')(db)


