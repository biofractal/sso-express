module.exports =
	development:
		app:
			name: 'SSO-Express Development'
			port: process.env.PORT or 3000
			idp:'openid'

		passport:
			saml:
				issuer: 'sso-express.localhost'
				identifierFormat: 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified'
				path: '/saml/consume'
				privateKey:'sso-express.key'
				openid:
					entryPoint:'https://openidp.feide.no/simplesaml/saml2/idp/SSOService.php'
				testshib:
					entryPoint:'https://idp.testshib.org/idp/profile/SAML2/Redirect/SSO'
