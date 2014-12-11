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
				$scope.tenants = tenants.data
		.state 'user',
			templateUrl: "user.html"
			params:{'tenantKey':{}, 'strategyName':{}}
			resolve:
				user:($http, $stateParams)->
					$http.get "api/sso/#{$stateParams.tenantKey}/initiate/#{$stateParams.strategyName}"
					.success (data)->
						console.log 'data', data
					.error (data, status, headers, config)->
						console.log 'data', data
						console.log 'status', status
						console.log 'headers', headers()
						console.log 'config', config
			controller: ($scope, user)->
				$scope.user = user.data
