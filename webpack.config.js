const path = require('path');
const glob = require('glob');
const webpack = require('webpack');
const { WebpackManifestPlugin } = require('webpack-manifest-plugin')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

let entries = {};
glob.sync('./frontend/**/*.{js,jsx,ts,tsx,css,scss,sass}').map((file) => {
  let name = file.split('/')[3].split('.')[0];
  entries[name] = file;
})

module.exports = {
  entry: entries,
  output: {
    filename: "[name]-[hash].js",
    path: path.join(__dirname, 'public', 'assets'),
    publicPath: "/",
    clean: true,
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      },
      {
        test: /\.scss$/,
        use: [
          process.env.NODE_ENV !== 'production'
            ? 'style-loader' : MiniCssExtractPlugin.loader,
          'css-loader',
          'sass-loader',
        ]
      },
      {
        test: /.(png|jpg|jpeg|gif|svg|woff|woff2|ttf|eot)$/,
        use: "url-loader?limit=100000"
      },
    ],
  },
  resolve: {
    modules: [path.join(__dirname, 'node_modules')],
    extensions: ['.js', '.jsx']
  },
  plugins: [
    new WebpackManifestPlugin({
      writeToFileEmit: true
    }),
    new MiniCssExtractPlugin({
      filename: '[name].css'
    }),
  ],
};
