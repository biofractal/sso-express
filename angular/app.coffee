angular
.module 'sso-express', ['ui.router']
.config ($stateProvider) ->
	$stateProvider
		.state 'home',
			url:'/home'
			templateUrl: "home.html"
			resolve:
				tenants:($http)->
					$http.get 'api/tenants'
			controller: ($scope, tenants)->
				console.log 'tenants', tenants
				$scope.tenants = tenants.data



