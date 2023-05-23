config.module.rules.push({
    test: /\.css$/,
//old    loader: 'style-loader!css-loader'
    use: ['style-loader', 'css-loader'],
});