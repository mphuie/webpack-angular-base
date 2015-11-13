require 'angular'
require 'ui-router'
require 'ui-bootstrap'
require 'toaster'
require 'angularAnimate'

app = angular.module 'app', ['ui.router', 'ui.bootstrap', 'toaster', 'ngAnimate']

routes = require './routes'

app.config routes

app.factory 'xsfrToken', ['$rootScope', ($rootScope) ->
	sessionInjector =
		request: (config) ->
			if 'accessToken' of $rootScope
				console.log $rootScope.accessToken
				config.headers['X-Auth-Token'] = $rootScope.accessToken
			else
				console.log 'no auth token defined!!!'
			config

	sessionInjector
]

app.config ['$httpProvider', ($httpProvider) ->
	$httpProvider.interceptors.push 'xsfrToken'
]

angular.element(document).ready ->
  angular.bootstrap document, ['app'], {}
