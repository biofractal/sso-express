
module.exports = (db)->
	tenants = db.get 'tenants'

	findByKey:(key, next) ->
		tenants.findOne {key:key}, (err, tenant)->
			return next err if err?
			next null, tenant
