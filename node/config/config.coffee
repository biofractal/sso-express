module.exports = development:
	app:
		name: "SSO-Express Development"
		port: process.env.PORT or 3000
		secret: 'tpqu48#nc0$g#xu48v-*w)(ob(f+46f2c#jy*ef&$4xr@2r-r%'

	mongo:
		url: 'mongodb://biofractal:R0ZDILn0G1Fv@ds033400.mongolab.com:33400/sso-express'

	passport:
		strategy: "saml"
		saml:
			path: "/saml/consume"
			entryPoint: "https://openidp.feide.no/simplesaml/saml2/idp/SSOService.php"
			issuer: "sso-express.localhost"