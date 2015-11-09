module.exports = ($scope, $http, $rootScope) ->

  $scope.newServer =
    server: {
      security_groups: []
      imageRef: ''
      flavorRef: ''
      networks: []
      name: ''
      source_type: 'image'
    }

  $scope.setWindows = ->
    $scope.newServer.server.image = '68fbafa1-106d-4195-8e46-c5baaa90487b'
    $scope.newServer.server.flavor = 'm1.medium'
    $scope.newServer.server.securityGroup = '3e03d215-2b9a-41ae-ac64-9b7787a3f45e'

  $scope.loadTenantResources = ->
    $http
      .get "/images/#{$scope.selectedTenant.name}"
      .success (data) ->
        $scope.images = data.images

    $http
      .get "/flavors/#{$scope.selectedTenant.name}"
      .success (data) ->
        $scope.flavors = data.flavors

    $http
      .get "/networks/#{$scope.selectedTenant.name}"
      .success (data) ->
        $scope.networks = data.networks

    $http
      .get "/security-groups/#{$scope.selectedTenant.name}"
      .success (data) ->
        $scope.securityGroups = data.security_groups

  $http
    .get "/tenants"
    .success (data) ->
      $scope.tenants = data.tenants

  $scope.createServer = ->
    networks = _.chain $scope.networks
                .where { selected: true }
                .pluck 'id'
                .map (e) ->
                  { uuid: e }
                .value()

    securityGroups = _.chain $scope.securityGroups
                      .where { selected: true }
                      .map (e) ->
                        { name: e.name}
                      .value()


    $scope.newServer.server.networks = networks
    $scope.newServer.server.security_groups = securityGroups

    console.log $scope.newServer
    console.log $scope.selectedTenant

    $http
      .post "/servers/#{$scope.selectedTenant.id}", $scope.newServer
