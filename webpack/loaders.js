const MiniCssExtractPlugin = require("mini-css-extract-plugin");

const JSLoader = {
  test: /source\/javascripts\/.*\.js$/,
  exclude: /node_modules|\.tmp|vendor/,
  use: {
    loader: 'babel-loader',
    options: {
      presets: ['@babel/preset-env']
    }
  }
};

const CSSLoader = {
  test: /\.(sa|sc|c)ss$/,
  exclude: /node_modules/,
  use: [{
      loader: MiniCssExtractPlugin.loader,
      options: {
        publicPath: __dirname + '/stylesheets/',
        sourceMap: true
      }
    },
    {
      loader: 'css-loader',
      options: {
        sourceMap: true
      }
    },
    {
      loader: 'sass-loader',
      options: {
        sourceMap: true
      }
    }
  ],
};

module.exports = {
  JSLoader: JSLoader,
  CSSLoader: CSSLoader
};