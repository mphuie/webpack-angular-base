require 'angular'
require 'ui-router'
require 'ui-bootstrap'

app = angular.module 'app', ['ui.router', 'ui.bootstrap']

routes = require './routes'

app.config routes



angular.element(document).ready ->
  angular.bootstrap document, ['app'], {}