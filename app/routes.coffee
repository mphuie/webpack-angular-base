module.exports = ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/provision'

  $stateProvider
    .state 'root',
      url: '/root'
      template: require './partials/root.jade'
      controller: require './controllers/rootCtrl'

    .state 'auth',
      url: '/auth'
      template: require './partials/auth.jade'
      controller: require './controllers/auth'

    .state 'provision',
      url: '/provision'
      template: require './partials/provision.jade'
      controller: require './controllers/provision'
