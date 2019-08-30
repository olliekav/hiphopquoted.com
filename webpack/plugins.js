const _MiniCssExtractPlugin = require('mini-css-extract-plugin');
const webpack = require('webpack');

const MiniCssExtractPlugin = new _MiniCssExtractPlugin({
  filename: 'stylesheets/[name].css',
  chunkFilename: '[id].css'
});

const ProvidePlugin = new webpack.ProvidePlugin({
  $: "jquery",
  jQuery: "jquery",
  "window.jQuery": "jquery"
});

module.exports = {
  ProvidePlugin: ProvidePlugin,
  MiniCssExtractPlugin: MiniCssExtractPlugin
};