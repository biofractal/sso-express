module.exports = (app, config, passport)->

	app.get '/saml/initiate',
		passport.authenticate config.passport.strategy,
			successRedirect: "/"
			failureRedirect: "/saml/initiate"

	app.post '/saml/consume',
		passport.authenticate config.passport.strategy,
			successRedirect: "/"
			failureRedirect: "/"
			failureFlash: true
