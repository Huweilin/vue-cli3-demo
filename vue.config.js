const webpack = require('webpack')
function resolve (dir) {
  return path.join(__dirname, dir)
}
module.exports = {
  pages: {
    index: {
      entry: 'src/pages/index/main.ts',
      template: 'public/index.html',
      filename: 'index.html',
      chunks: ['chunk-vendors', 'index']
    },
    page01: {
      entry: 'src/pages/page01/main.ts',
      template: 'public/page01.html',
      filename: 'page01.html',
      chunks: ['chunk-vendors', 'page01']
    }
  },
  // configureWebpack:{
  //   externals: {
  //      'AMap' : 'AMap',
  //   }
  // },
  devServer: {
    watchOptions: {
      aggregateTimeout: 300,
      ignored: /node_modules/,
      poll: 1000,
    }
  }
}