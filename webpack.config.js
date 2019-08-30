const path = require('path');
const loaders = require('./webpack/loaders.js');
const plugins = require('./webpack/plugins.js');
const glob = require("glob");
const TerserPlugin = require('terser-webpack-plugin');

const mapFilenamesToEntries = pattern => glob
  .sync(pattern)
  .reduce((entries, filename) => {
    const [, name] = filename.match(/([^/]+)\.scss$/)
    return { ...entries, [name]: filename }
  }, {})

module.exports = {
  context: __dirname + "/source",
  entry: {
    application: './javascripts/application.js',
    'scroll-animations': './javascripts/scroll-animations.js',
    ...mapFilenamesToEntries('./src/*.scss')
  },
  resolve: {
    alias: {
      "TweenLite": path.resolve('node_modules', 'gsap/src/minified/TweenLite.min.js'),
      "TweenMax": path.resolve('node_modules', 'gsap/src/minified/TweenMax.min.js'),
      "TimelineLite": path.resolve('node_modules', 'gsap/src/minified/TimelineLite.min.js'),
      "TimelineMax": path.resolve('node_modules', 'gsap/src/minified/TimelineMax.min.js'),
      "SmoothScroll": path.resolve('node_modules', 'smooth-scroll/dist/smooth-scroll.min'),
      "ScrollMagic": path.resolve('node_modules', 'scrollmagic/scrollmagic/minified/ScrollMagic.min.js'),
      "animation.gsap": path.resolve('node_modules', 'scrollmagic/scrollmagic/minified/plugins/animation.gsap.min.js'),
      "debug.addIndicators": path.resolve('node_modules', 'scrollmagic/scrollmagic/minified/plugins/debug.addIndicators.min.js'),
      "bigtext": "bigtext/dist/bigtext.js"
    },
  },
  module: {
    rules: [
      loaders.JSLoader,
      loaders.CSSLoader
    ]
  },
  plugins: [
    plugins.ProvidePlugin,
    plugins.MiniCssExtractPlugin,
  ],
  optimization: {
    minimizer: [
      new TerserPlugin({
        terserOptions: {
          keep_fnames: true
        }
      })
    ],
  },
  output: {
    filename: 'javascripts/[name].bundle.js',
    path: path.resolve(__dirname, '.tmp/dist')
  }
};