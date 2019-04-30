const webpack = require('webpack')

module.exports = {
  configureWebpack:{
    externals: {
       'AMap' : 'AMap',
    }
  },
}