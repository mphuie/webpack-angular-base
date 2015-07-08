require 'angular'
require 'ui-router'

app = angular.module 'app', ['ui.router']

routes = require './routes'

app.config routes



angular.element(document).ready ->
  angular.bootstrap document, ['app'], {}