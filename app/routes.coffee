module.exports = ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state 'root',
      url: '/'
      template: require './partials/root.jade'
      controller: require './controllers/rootCtrl'