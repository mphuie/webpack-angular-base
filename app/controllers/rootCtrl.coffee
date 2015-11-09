module.exports = ($scope, $http, $rootScope) ->
  $scope.tenants = [
    'Sandbox_Online',
    'Sandbox_Public',
    'Sandbox_SSO',
    'admin'
  ]


  $scope.login = ->
    console.log 'process login!'

    payload = 
      auth:
        tenantName: $scope.selectedTenant
        passwordCredentials:
          username: $scope.username
          password: $scope.password

    $http
      .post '/api/v2.0/tokens', payload
      .success (data) ->
        console.log data

        $rootScope.accessToken = data.access.token.id
        $rootScope.authTenant = $scope.selectedTenant
        $rootScope.authTenantId = data.access.token.tenant.id
        
      .error ->
        $scope.accessToken = "Invalid credentials/can't authorize"

  $scope.loadImageList = ->
    $http
      .get "http://10.3.14.10:8774/v2/#{$scope.selectedTenant.model.id}/images/detail"
      .success (data) ->
        $scope.images = data.images

  $scope.loadServerList = ->
    $http
      .get "http://10.3.14.10:8774/v2/#{$scope.selectedTenant.model.id}/servers/detail"
      .success (data) ->
        $scope.servers = data.servers      