'use strict'

var webpack = require('webpack');
var path = require('path');

var angularPath = path.resolve(__dirname, 'app/lib/angular.min.js');
var angularUiRouterPath = path.resolve(__dirname, 'app/lib/angular-ui-router.min.js');

var PATHS = {
  app: __dirname + '/app',
};

module.exports = {
  context: PATHS.app,
  entry: {
    app: ['webpack/hot/dev-server', './index.coffee']
  },
  output: {
    path: PATHS.app,
    filename: 'bundle.js'
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
    alias: { 'angular': angularPath, 'ui-router': angularUiRouterPath }

  }
};