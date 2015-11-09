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

        $scope.auth = data

