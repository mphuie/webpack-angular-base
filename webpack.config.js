'use strict'

var webpack = require('webpack');
var path = require('path');

var angularPath = path.resolve(__dirname, 'app/lib/angular.min.js');
var angularUiRouterPath = path.resolve(__dirname, 'app/lib/angular-ui-router.min.js');
var angularUiBootstrapPath = path.resolve(__dirname, 'app/lib/ui-bootstrap-tpls-0.13.4.min.js')
var angularToaster = path.resolve(__dirname, 'app/lib/toaster.min.js')
var angularAnimate = path.resolve(__dirname, 'app/lib/angular-animate.min.js')

var appPath = path.resolve(__dirname, 'app');
var buildPath = path.resolve(__dirname, 'public', 'build')

module.exports = {
  context: __dirname,
  entry: {
    app: [
      'webpack/hot/dev-server',
      path.resolve(appPath, 'index.coffee')
    ]
  },
  output: {
    path: buildPath,
    filename: 'bundle.js',
    publicPath: 'http://localhost:4000/build/'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.jade$/, loader: 'jade-loader' }
    ],

    noParse: [angularPath, angularUiRouterPath]
  },
  resolve: {
    extensions: ['', '.js', '.json', '.coffee'],
    alias: {
      'angular': angularPath,
      'angularAnimate': angularAnimate,
      'ui-router': angularUiRouterPath,
      'ui-bootstrap': angularUiBootstrapPath,
      'toaster': angularToaster
    }
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ]
};
