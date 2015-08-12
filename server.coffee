webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
config = require './webpack.config'
express = require 'express'
path = require 'path'
bodyparser = require 'body-parser'

app = express()
appPath = path.resolve __dirname, 'public'

app.use express.static appPath
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
  console.log 'Listening on 4000...'