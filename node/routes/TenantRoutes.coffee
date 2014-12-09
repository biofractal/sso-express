router = require('express').Router()


module.exports = (db)->
	tenantService = require('./TenantService') db

	router.get '/tenants', (req, res)->
		tenants = tenantService.getTenants (err, tenants)->
			res.send tenants

	router