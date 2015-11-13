module.exports = ($scope, $http, $rootScope, toaster) ->



  $scope.newServer =
    server: {
      security_groups: []
      imageRef: ''
      flavorRef: ''
      networks: []
      name: ''
      source_type: 'image'
    }

  $http
    .get '/presets'
    .success (data) ->
      $scope.presets = data

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
    if not $scope.selectedPreset
      console.log 'creating server from manual options'
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
      $scope.newServer.server.user_data = btoa $scope.userdata
    else
      console.log 'creating server from preset!'

    $scope.newServer.server.metadata = { name: $scope.newServer.server.name }

    $http
      .post "/servers/#{$scope.selectedTenant.id}", $scope.newServer
      .success (data) ->
        toaster.pop 'success', 'New server', 'GOod!'
        $scope.newServerDetails = data
      .error (data) ->
        toaster.pop 'error', 'New server', 'Your preset config was saved!'
        console.log data

  $scope.selectPreset = ->
    name = $scope.newServer.server.name
    $scope.newServer = $scope.selectedPreset.payload
    $scope.newServer.server.name = name
    console.log $scope.newServer
    $scope.selectedTenant = { id: $scope.selectedPreset.tenantId }


  $scope.addPreset = ->

    console.log 'creating server from manual options!'
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
    $scope.newServer.server.user_data = btoa $scope.userdata

    $http
      .post '/presets', { name: $scope.newPresetName, tenantId: $scope.selectedTenant.id, payload: $scope.newServer }
      .success ->
        toaster.pop 'success', 'New preset', 'Your preset config was saved!'
