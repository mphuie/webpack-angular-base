webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
config = require './webpack.config'
express = require 'express'
path = require 'path'
bodyparser = require 'body-parser'
proxy = require 'express-http-proxy'
request = require 'request'

app = express()
appPath = path.resolve __dirname, 'public'

app.use express.static appPath
app.use '/api', proxy('http://10.3.14.10:5000')
app.use bodyparser.json()
app.use bodyparser.urlencoded { extended: false }

app.listen 4001, ->
  console.log 'Express server running on port 4001'

server = new WebpackDevServer webpack(config),
  hot: true
  publicPath: '/build/'
  inline: true
  proxy:
    '*': 'http://localhost:4001'

server.listen 4000, '0.0.0.0', (err) ->
  if err
    console.log err
  console.log 'Webpack dev server listening on 4000...'


app.get '/tenants', (req, res) ->
  auth_data = {
    auth: {
      tenantName: 'Sandbox_Online'
      passwordCredentials: {
        username: 'mhuie'
        password: 'Sh0ryuk3n'
      }
    }
  }

  options = {
    url: 'http://10.3.14.10:5000/v2.0/tokens'
    method: 'POST'
    json: auth_data
  }

  request options, (e, r, b) ->
    authToken = b.access.token.id
    console.log b.access.token.tenant

    options = {
      url: 'http://10.3.14.10:5000/v2.0/tenants'
      method: 'GET'
      headers: {
        'X-Auth-Token': authToken
      }
    }

    request options, (e, r, b) ->
      res.json JSON.parse(b)

app.get '/images/:tenantName', (req, res) ->
  auth_data = {
    auth: {
      tenantName: req.params.tenantName
      passwordCredentials: {
        username: 'mhuie'
        password: 'Sh0ryuk3n'
      }
    }
  }

  options = {
    url: 'http://10.3.14.10:5000/v2.0/tokens'
    method: 'POST'
    json: auth_data
  }

  request options, (e, r, b) ->
    tenantId = b.access.token.tenant.id
    authToken = b.access.token.id

    options = {
      url: "http://10.3.14.10:8774/v2/#{tenantId}/images/detail"
      method: 'GET'
      headers: {
        'X-Auth-Token': authToken
      }
    }

    request options, (e, r, b) ->
      res.json JSON.parse(b)

app.get '/flavors/:tenantName', (req, res) ->
  auth_data = {
    auth: {
      tenantName: req.params.tenantName
      passwordCredentials: {
        username: 'mhuie'
        password: 'Sh0ryuk3n'
      }
    }
  }

  options = {
    url: 'http://10.3.14.10:5000/v2.0/tokens'
    method: 'POST'
    json: auth_data
  }

  request options, (e, r, b) ->
    tenantId = b.access.token.tenant.id
    authToken = b.access.token.id

    options = {
      url: "http://10.3.14.10:8774/v2/#{tenantId}/flavors/detail"
      method: 'GET'
      headers: {
        'X-Auth-Token': authToken
      }
    }

    request options, (e, r, b) ->
      res.json JSON.parse(b)

app.get '/networks/:tenantName', (req, res) ->
  auth_data = {
    auth: {
      tenantName: req.params.tenantName
      passwordCredentials: {
        username: 'mhuie'
        password: 'Sh0ryuk3n'
      }
    }
  }

  options = {
    url: 'http://10.3.14.10:5000/v2.0/tokens'
    method: 'POST'
    json: auth_data
  }

  request options, (e, r, b) ->

    tenantId = b.access.token.tenant.id
    authToken = b.access.token.id

    options = {
      url: "http://10.3.14.10:8774/v2/#{tenantId}/os-networks"
      method: 'GET'
      headers: {
        'X-Auth-Token': authToken
      }
    }

    request options, (e, r, b) ->
      res.json JSON.parse(b)

app.get '/security-groups/:tenantName', (req, res) ->
  auth_data = {
    auth: {
      tenantName: req.params.tenantName
      passwordCredentials: {
        username: 'mhuie'
        password: 'Sh0ryuk3n'
      }
    }
  }

  options = {
    url: 'http://10.3.14.10:5000/v2.0/tokens'
    method: 'POST'
    json: auth_data
  }

  request options, (e, r, b) ->
    tenantId = b.access.token.tenant.id
    authToken = b.access.token.id

    options = {
      url: "http://10.3.14.10:8774/v2/#{tenantId}/os-security-groups"
      method: 'GET'
      headers: {
        'X-Auth-Token': authToken
      }
    }

    request options, (e, r, b) ->
      res.json JSON.parse(b)


app.post '/servers/:tenantId', (req, res) ->
  console.log req.body
  auth_data = {
    auth: {
      tenantName: 'Sandbox_Online'
      passwordCredentials: {
        username: 'mhuie'
        password: 'Sh0ryuk3n'
      }
    }
  }

  options = {
    url: 'http://10.3.14.10:5000/v2.0/tokens'
    method: 'POST'
    json: auth_data
  }

  request options, (e, r, b) ->
    authToken = b.access.token.id
    console.log authToken
    options = {
      url: "http://10.3.14.10:8774/v2/#{req.params.tenantId}/servers"
      method: 'POST'
      headers: {
        'X-Auth-Token': authToken
      }
      json: req.body
    }

    request options, (e, r, b) ->
      if e
        console.log e
        res.send 'error!'
      else
        console.log b
        res.json b
