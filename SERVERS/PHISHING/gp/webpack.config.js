const path = require('path');

module.exports = {
    context: path.resolve(__dirname, 'static', 'js', 'src', 'app'),
    entry: {
        users: './users',
    },
    output: {
        path: path.resolve(__dirname, 'static', 'js', 'dist', 'app'),
        filename: '[name].min.js'
    },
    module: {
        rules: [{
            test: /\.js$/,
            exclude: /node_modules/,
            use: {
                loader: "babel-loader"
            }
        }]
    }
}