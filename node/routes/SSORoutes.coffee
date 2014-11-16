module.exports = (app, config, passport)->

	app.get '/saml/initiate',
		passport.authenticate 'saml',
			successRedirect: "/"
			failureRedirect: "/saml/initiate"

	app.post '/saml/consume',
		passport.authenticate 'saml',
			successRedirect: "/"
			failureRedirect: "/"
			failureFlash: true
