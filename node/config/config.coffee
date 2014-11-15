module.exports = development:
	app:
		name: "SSO-Express Development"
		port: process.env.PORT or 3000

	passport:
		strategy: "saml"
		saml:
			path: "/saml/consume"
			entryPoint: "https://openidp.feide.no/simplesaml/saml2/idp/SSOService.php"
			issuer: "sso-express.localhost"