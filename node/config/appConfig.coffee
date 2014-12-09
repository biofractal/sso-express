module.exports =
	development:
		app:
			name: 'SSO-Express Development'
			port: process.env.PORT or 3000

		passport:
			saml:
				issuer: 'sso-express.localhost'
				privateKeyFile:'sso-express.key'
				path:'/api/sso/consume/saml'
